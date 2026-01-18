import os
import json
import glob
import argparse
import shutil
import sys
from datetime import datetime
from typing import List, Tuple, Optional

sys.path.append(os.path.join(os.path.dirname(__file__), '..'))

from utils.file_utils import read_file, write_to_file
from utils.bash_utils import remove_color_codes
from compile.cj_compiler import compile_and_run_cj, compile_and_run_cj_single
from compile.java_compiler import compile_and_run_java
from translator import Translator

from error_parser import CangJieErrorParser, ErrorInfo
from rag_retriever import RAGRetriever, RetrievedCase
from prompt_builder import PromptBuilder


class RAGRepairSystem:
    def __init__(self,
                 error_db_path: str,
                 model_name: str = "LLAMA3-1",
                 similarity_threshold: float = 0.5, 
                 top_k: int = 2,
                 max_iters: int = 3,
                 temperature: float = 0.2,
                 top_p: float = 1.0,
                 max_prompt_length: int = 6000,
                 debug: bool = False):
      
        self.debug = debug
        self.max_iters = max_iters
        

        self.error_parser = CangJieErrorParser()
        self.retriever = RAGRetriever(
            excel_path=error_db_path,
            similarity_threshold=similarity_threshold,
            top_k=top_k
        )
        self.prompt_builder = PromptBuilder(
            max_prompt_length=max_prompt_length,
            include_examples=True
        )
        self.translator = Translator(model_name=model_name)

        self.temperature = temperature
        self.top_p = top_p
        
        if self.debug:
            print(f"[RAG修复系统] 初始化完成")
            print(f"  - 错误库: {error_db_path}")
            print(f"  - 相似度阈值: {similarity_threshold}")
            print(f"  - Top-K: {top_k}")
            print(f"  - 最大迭代: {max_iters}")
    
    def evaluate_code(self, 
                     cj_test_code: str, 
                     cj_target_code: str,
                     java_test_code: str,
                     java_target_code: str) -> Tuple[str, str, Optional[str], Optional[str], str]:
        merged = cj_test_code.replace("//TOFILL", cj_target_code)

        compile_out, _ = compile_and_run_cj_single(merged)
        compile_out = remove_color_codes(str(compile_out))
        
        if "error" in compile_out.lower():
            return "compile_error", compile_out, None, None, merged

        cj_compile_out, cj_run_out = compile_and_run_cj(cj_test_code, cj_target_code)
        java_compile_out, java_run_out = compile_and_run_java(java_test_code, java_target_code)
        cj_compile_out = remove_color_codes(str(cj_compile_out))

        if cj_run_out is None or "error" in cj_compile_out.lower():
            return "runtime_error", cj_compile_out, cj_run_out, java_run_out, merged

        if java_run_out and str(cj_run_out).strip() == str(java_run_out).strip():
            return "pass", "", cj_run_out, java_run_out, merged
        
        return "runtime_mismatch", "", cj_run_out, java_run_out, merged
    
    def fix_code_with_rag(self,
                         current_code: str,
                         java_code: str,
                         error_output: str,
                         mode: str,
                         java_run_out: Optional[str] = None,
                         cj_run_out: Optional[str] = None) -> Tuple[str, List[RetrievedCase], str]:

        retrieved_cases = []
        
        if mode == "compile_error":
            errors = self.error_parser.parse(error_output)
            
            if self.debug:
                print(f"\n {len(errors)} eroors")
                print(self.error_parser.format_for_display(errors))
            
            if len(errors) > 0:
                main_error = errors[0]
                retrieved_cases = self.retriever.retrieve(
                    error_message=main_error.error_message,
                    note_message=main_error.note_message
                )
            
            prompt = self.prompt_builder.build_prompt(
                current_errors=errors,
                java_code=java_code,
                cangjie_code=current_code,
                retrieved_cases=retrieved_cases if len(retrieved_cases) > 0 else None,
                mode=mode
            )
            
        else:  
            prompt = self.prompt_builder.build_runtime_mismatch_prompt(
                java_code=java_code,
                cangjie_code=current_code,
                java_output=str(java_run_out or ""),
                cangjie_output=str(cj_run_out or ""),
                retrieved_cases=None 
            )
        
        sys_msg = {"role": "system", "content": prompt['system']}
        user_msg = {"role": "user", "content": prompt['user']}
        
        fixed_code = self.translator.chat(
            [sys_msg, user_msg],
            max_tokens=2048,
            temperature=self.temperature,
            top_p=self.top_p
        )
        if fixed_code.startswith("```"):
            fixed_code = fixed_code.strip("`")
            if "\n" in fixed_code:
                lines = fixed_code.split("\n")
                if lines[0].strip() in ["cangjie", "cj", ""]:
                    fixed_code = "\n".join(lines[1:])
        
        return fixed_code.strip(), retrieved_cases, fixed_code
    
    def repair_case(self,
                   case_dir: str,
                   log_dir: str) -> dict:
        case_name = os.path.basename(case_dir)

        cj_test_path = os.path.join(case_dir, "cj_test.cj")
        cj_tr_path = os.path.join(case_dir, "cj_target_translation.cj")
        java_test_path = os.path.join(case_dir, "java_test.java")
        java_target_path = os.path.join(case_dir, "java_target.java")
        
        cj_test_code = read_file(cj_test_path)
        cj_code = read_file(cj_tr_path)
        java_test_code = read_file(java_test_path)
        java_target_code = read_file(java_target_path)

        backup_path = os.path.join(case_dir, "cj_target_translation_backup.cj")
        if not os.path.exists(backup_path):
            shutil.copy(cj_tr_path, backup_path)
        
        status, compile_out, cj_out, java_out, merged = self.evaluate_code(
            cj_test_code, cj_code, java_test_code, java_target_code
        )
        
        case_record = {
            "case": case_name,
            "initial_status": status,
            "iterations": []
        }
        
        if self.debug:
            print(f"\n{'='*60}")
            print(f"[{case_name}] state: {status}")
        
        if status == "pass":
            case_record["final_status"] = "pass"
            case_record["rag_used"] = False
            return case_record

        for k in range(1, self.max_iters + 1):
            iter_log_path = os.path.join(log_dir, f"iter_{k}.txt")
            
            if self.debug:
                print(f"\n[{case_name}] === iteration {k} ===")

            if status == "compile_error":
                fixed_code, retrieved_cases, llm_response = self.fix_code_with_rag(
                    current_code=cj_code,
                    java_code=java_target_code,
                    error_output=compile_out,
                    mode="compile_error"
                )
            else:  # runtime_mismatch
                fixed_code, retrieved_cases, llm_response = self.fix_code_with_rag(
                    current_code=cj_code,
                    java_code=java_target_code,
                    error_output="",
                    mode="runtime_mismatch",
                    java_run_out=java_out,
                    cj_run_out=cj_out
                )
            
            iter_code_path = os.path.join(case_dir, f"cj_target_translation_iter{k}.cj")
            write_to_file(iter_code_path, fixed_code)

            log_content = [
                f"### Iteration {k} ###",
                f"Status before: {status}",
                f"\n### RAG Retrieved Cases: {len(retrieved_cases)} ###"
            ]
            
            for i, case in enumerate(retrieved_cases, 1):
                log_content.append(f"\n--- Cangjie Code Snippets Repair Case {i} (Similarity: {case.similarity:.3f}) ---")
                log_content.append(f"Error: {case.error_message}")
                log_content.append(f"Suggestion: {case.fix_suggestion}")
                if case.error_case:
                    log_content.append(f"Before Modification:\n{case.error_case}")
                if case.correct_case:
                    log_content.append(f"After Modification:\n{case.correct_case}")
            
            log_content.append(f"\n### Fixed Code ###\n{fixed_code}")
            write_to_file(iter_log_path, "\n".join(log_content))
            
            status, compile_out, cj_out, java_out, merged = self.evaluate_code(
                cj_test_code, fixed_code, java_test_code, java_target_code
            )
            
            iter_record = {
                "iter": k,
                "rag_cases_found": len(retrieved_cases),
                "rag_used": len(retrieved_cases) > 0,
                "status_after_fix": status,
                "cj_run_out": None if cj_out is None else str(cj_out),
                "java_run_out": None if java_out is None else str(java_out)
            }
            
            if len(retrieved_cases) > 0:
                iter_record["rag_similarities"] = [c.similarity for c in retrieved_cases]
            
            case_record["iterations"].append(iter_record)
            
            if self.debug:
                print(f"[{case_name}] iteration {k} : {status}")
                print(f"  - RAG cases: {len(retrieved_cases)}")
            
            if status == "pass":
                if self.debug:
                    print(f"[{case_name}] ✓ success!")
                break
            
            cj_code = fixed_code
        
        case_record["final_status"] = status
        case_record["rag_used"] = any(iter_rec["rag_used"] for iter_rec in case_record["iterations"])
        
        return case_record


def main():
    parser = argparse.ArgumentParser(
        description="RAG-enhanced Compiler-Feedback Repair for Java→Cangjie translation"
    )
    parser.add_argument("--input", type=str, required=True,
                       help="Root directory of translation results")
    parser.add_argument("--error-db", type=str, required=True,
                       help="Path to error cases Excel database")
    parser.add_argument("--error-json", type=str, default="",
                       help="Optional JSON file containing failed cases")
    parser.add_argument("--model", type=str, default="LLAMA3-1",
                       help="LLM model name")
    parser.add_argument("--max-iters", type=int, default=3,
                       help="Maximum repair iterations per case")
    parser.add_argument("--similarity-threshold", type=float, default=0.3,
                       help="RAG similarity threshold (0-1)")
    parser.add_argument("--top-k", type=int, default=3,
                       help="Number of similar cases to retrieve")
    parser.add_argument("--temperature", type=float, default=0.2,
                       help="LLM temperature")
    parser.add_argument("--top-p", type=float, default=1.0,
                       help="LLM top-p")
    parser.add_argument("--max-prompt-len", type=int, default=6000,
                       help="Maximum prompt length")
    parser.add_argument("--debug", action="store_true",
                       help="Enable debug output")
    
    args = parser.parse_args()

    case_dirs = [d for d in glob.glob(os.path.join(args.input, "*")) 
                 if os.path.isdir(d)]
    
    if args.error_json and os.path.exists(args.error_json):
        try:
            failed = json.load(open(args.error_json, "r", encoding="utf-8"))
            allow_names = set(
                os.path.basename(str(x.get("case", "")).replace("/", os.sep).replace("\\", os.sep))
                for x in failed if "case" in x
            )
            case_dirs = [d for d in case_dirs if os.path.basename(d) in allow_names]
            print(f"[filter]  {len(case_dirs)} ")
        except Exception as e:
            print(f"[waening] cant parse error-json: {e}. ")
    
    repair_system = RAGRepairSystem(
        error_db_path=args.error_db,
        model_name=args.model,
        similarity_threshold=args.similarity_threshold,
        top_k=args.top_k,
        max_iters=args.max_iters,
        temperature=args.temperature,
        top_p=args.top_p,
        max_prompt_length=args.max_prompt_len,
        debug=args.debug
    )

    summary = {
        "date": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "input_root": os.path.abspath(args.input),
        "error_database": os.path.abspath(args.error_db),
        "config": {
            "max_iters": args.max_iters,
            "similarity_threshold": args.similarity_threshold,
            "top_k": args.top_k,
            "model": args.model
        },
        "cases": []
    }
    
    print(f"\n{'='*60}")
    print(f"{'='*60}")
    print(f"case: {len(case_dirs)}")
    print(f"error db: {args.error_db}")
    print(f"similarity threshold: {args.similarity_threshold}")
    print(f"{'='*60}\n")
    
    for case_dir in case_dirs:
        case_name = os.path.basename(case_dir)

        required_files = ["cj_test.cj", "cj_target_translation.cj", 
                         "java_test.java", "java_target.java"]
        if not all(os.path.exists(os.path.join(case_dir, f)) for f in required_files):
            if args.debug:
                print(f"[skip] {case_name}: Missing required file")
            continue
        
        log_dir = os.path.join(case_dir, "repair_logs_rag")
        os.makedirs(log_dir, exist_ok=True)

        try:
            case_record = repair_system.repair_case(case_dir, log_dir)
            summary["cases"].append(case_record)
        except Exception as e:
            print(f"[error] {case_name}: {e}")
            if args.debug:
                import traceback
                traceback.print_exc()
    total_cases = len(case_dirs)
    repaired_cases = len(summary["cases"])

    status_dist = {}
    rag_used_count = 0
    for c in summary['cases']:
        status = c['final_status']
        status_dist[status] = status_dist.get(status, 0) + 1
        if c.get('rag_used', False):
            rag_used_count += 1

    summary["statistics"] = {
        "total_cases": total_cases,
        "repaired_cases": repaired_cases,
        "final_status_distribution": status_dist,
        "rag_usage": {
            "rag_used_cases": rag_used_count,
            "total_repaired_cases": repaired_cases
        }
    }

    out_json = os.path.join(
        args.input, 
        f"repair_summary_rag_{datetime.now().strftime('%m%d_%H%M')}.json"
    )
    with open(out_json, "w", encoding="utf-8") as f:
        json.dump(summary, f, indent=2, ensure_ascii=False)

    print(f"\n{'='*60}")
    print(f"{'='*60}")
    print(f"input: {args.input}")
    print(f"case number: {len(case_dirs)}")
    print(f"success: {len(summary['cases'])}")
    
    status_dist = {}
    rag_used_count = 0
    for c in summary['cases']:
        status = c['final_status']
        status_dist[status] = status_dist.get(status, 0) + 1
        if c.get('rag_used', False):
            rag_used_count += 1
    
    for status, count in sorted(status_dist.items()):
        print(f"  {status}: {count}")

    print(f"  use RAG: {rag_used_count}/{len(summary['cases'])}")
    
    print(f"\n {out_json}")
    print(f"{'='*60}\n")

if __name__ == "__main__":
    main()
