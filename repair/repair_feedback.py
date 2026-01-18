import os
import json
import glob
import argparse
import shutil
from datetime import datetime

from utils.file_utils import read_file, write_to_file
from utils.bash_utils import remove_color_codes
from compile.cj_compiler import compile_and_run_cj, compile_and_run_cj_single
from compile.java_compiler import compile_and_run_java
from translator import Translator


def main():
    parser = argparse.ArgumentParser(description="Compiler-Feedback Repair for Java→Cangjie translation outputs.")
    parser.add_argument("--input", type=str, required=True, help="Root directory of translation and evaluation results.")
    parser.add_argument("--error-json", type=str, default="", help="Optional JSON file containing failed cases.")
    parser.add_argument("--model", type=str, default="LLAMA3-1", help="LLM model name used in Translator.")
    parser.add_argument("--max-iters", type=int, default=3, help="Maximum repair iterations per case.")
    parser.add_argument("--temperature", type=float, default=0.2, help="Temperature for generation.")
    parser.add_argument("--top-p", type=float, default=1.0, help="Top-p for generation.")
    parser.add_argument("--debug", action="store_true", help="Enable detailed debugging logs.")
    parser.add_argument("--model-max-len", type=int, default=6000, help="Maximum total characters allowed for LLM prompt.")
    args = parser.parse_args()

    case_dirs = [d for d in glob.glob(os.path.join(args.input, "*")) if os.path.isdir(d)]
    if args.error_json and os.path.exists(args.error_json):
        try:
            failed = json.load(open(args.error_json, "r", encoding="utf-8"))
            allow_names = set(os.path.basename(str(x.get("case", "")).replace("/", os.sep).replace("\\", os.sep))
                              for x in failed if "case" in x)
            case_dirs = [d for d in case_dirs if os.path.basename(d) in allow_names]
        except Exception as e:
            print(f"[WARN] Could not parse error-json: {e}. Repairing all cases.")

    translator = Translator(model_name=args.model)
    summary = {
        "date": datetime.now().strftime("%Y-%m-%d %H:%M:%S"),
        "input_root": os.path.abspath(args.input),
        "max_iters": args.max_iters,
        "model": args.model,
        "cases": []
    }

    for case_dir in case_dirs:
        case_name = os.path.basename(case_dir)
        cj_test_path = os.path.join(case_dir, "cj_test.cj")
        cj_tr_path = os.path.join(case_dir, "cj_target_translation.cj")
        java_test_path = os.path.join(case_dir, "java_test.java")
        java_target_path = os.path.join(case_dir, "java_target.java")

        if not (os.path.exists(cj_test_path) and os.path.exists(cj_tr_path)
                and os.path.exists(java_test_path) and os.path.exists(java_target_path)):
            if args.debug:
                print(f"[SKIP] Missing files: {case_name}")
            continue

        cj_test_code = read_file(cj_test_path)
        cj_code = read_file(cj_tr_path)
        java_test_code = read_file(java_test_path)
        java_target_code = read_file(java_target_path)

        backup_path = os.path.join(case_dir, "cj_target_translation_backup.cj")
        if not os.path.exists(backup_path):
            shutil.copy(cj_tr_path, backup_path)

        log_dir = os.path.join(case_dir, "repair_logs")
        os.makedirs(log_dir, exist_ok=True)

        # ---------- Evaluation ----------
        def evaluate(cj_current: str):
            merged = cj_test_code.replace("//TOFILL", cj_current)
            compile_out, _ = compile_and_run_cj_single(merged)
            compile_out = remove_color_codes(str(compile_out))
            if "error" in compile_out.lower():
                return "compile_error", compile_out, None, None, merged
            cj_compile_out, cj_run_out = compile_and_run_cj(cj_test_code, cj_current)
            java_compile_out, java_run_out = compile_and_run_java(java_test_code, java_target_code)
            cj_compile_out = remove_color_codes(str(cj_compile_out))
            if cj_run_out is None or "error" in cj_compile_out.lower():
                return "runtime_error", cj_compile_out, cj_run_out, java_run_out, merged
            if java_run_out and str(cj_run_out).strip() == str(java_run_out).strip():
                return "pass", "", cj_run_out, java_run_out, merged
            return "runtime_mismatch", "", cj_run_out, java_run_out, merged

        # ---------- LLM helpers ----------
        def brief_suggestion(err_msg: str = "", mismatch: str = "", cj_code: str = ""):
            """
            Generate short fix hints from LLM using only:
            [Cangjie code] + [error or mismatch message] + [repair instruction]
            """
            sys_msg = {
                "role": "system",
                "content": (
                    "You are an senior Cangjie code engineer. "
                    "Generate concise fix suggestions based on the provided code and errors."
                )
            }
            if mismatch:
                user_content = (
                    "[Cangjie Code]\n" + cj_code.strip() + "\n\n"
                    "[Runtime Mismatch Info]\n" + mismatch.strip() + "\n\n"
                    "Please analyze the above Cangjie code and mismatch information, "
                    "provide a user-friendly modification suggestion in natural language(only one sentence)."
                )
            else:
                user_content = (
                    "[Cangjie Code]\n" + cj_code.strip() + "\n\n"
                    "[Compiler Error]\n" + err_msg.strip() + "\n\n"
                    "Please analyze the above Cangjie code and compiler errors, "
                    "provide a user-friendly modification suggestion in natural language(only one sentence)."
                )
            user_msg = {"role": "user", "content": user_content}
            return translator.chat([sys_msg, user_msg], max_tokens=256, temperature=0.1, top_p=1.0)



        def fix_code(java_src, cj_bad, mode, suggestion, java_out_ok="", cj_out_bad="", err=""):
            sys_msg = {"role": "system", "content": "You are a precise Cangjie code fixer. Return ONLY valid Cangjie code, no explanations."}
            parts = []
            if mode == "compile_error":
                parts.append("[Compiler Error Message]\n" + err)
            elif mode == "runtime_mismatch":
                parts.append("[Java Correct Output]\n" + java_out_ok)
                parts.append("[Cangjie Incorrect Output]\n" + cj_out_bad)
            parts.append("[Fix Suggestions]\n" + suggestion)
            parts.append("[Java Source Code]\n" + java_src)
            parts.append("[Current Cangjie Code]\n" + cj_bad)

            prompt = "\n\n".join(parts)
            # Safety truncation (LLM input too long)
            if len(prompt) > args.model_max_len:
                prompt = prompt[:args.model_max_len] + "\n\n[Truncated due to input length limit]\n"

            # --- skip Requirements if prompt > 4000 ---
            if len(prompt) > 4000:
                content = "Please provide the corrected Cangjie code based on the information above."
            else:
                content = (
                    "Requirements:\n"
                    "1. Output only compilable and runnable Cangjie code (no markdown fences).\n"
                    "2. Keep function name 'f_gold' and parameters consistent unless necessary.\n"
                    "3. Fix common issues such as String charAt, math import, collection API, and type mismatches.\n"
                    "4. Do not add the modifier 'static' in the function declaration"
                    "5. Do not add explanations or comments.\n\n"
                    + prompt
                )

            user_msg = {"role": "user", "content": content}
            fixed = translator.chat([sys_msg, user_msg], max_tokens=2048, temperature=args.temperature, top_p=args.top_p)
            if fixed.startswith("```"):
                fixed = fixed.strip("`")
                if "\n" in fixed:
                    fixed = fixed.split("\n", 1)[1]
            return fixed.strip()

        # ---------- Iteration ----------
        status, compile_out, cj_out, java_out, merged = evaluate(cj_code)
        case_record = {"case": case_name, "initial_status": status, "iterations": []}
        if args.debug:
            print(f"[{case_name}] Initial status: {status}")

        if status == "pass":
            case_record["final_status"] = "pass"
            summary["cases"].append(case_record)
            continue

        for k in range(1, args.max_iters + 1):
            iter_log = os.path.join(log_dir, f"iter_{k}.txt")

            if status == "compile_error":
                suggestion = brief_suggestion(err_msg=compile_out, cj_code=cj_code)
                fixed = fix_code(java_target_code, cj_code, "compile_error", suggestion, err=compile_out)
            else:
                mismatch = f"[Cangjie Output]\n{cj_out}\n\n[Java Output]\n{java_out}"
                suggestion = brief_suggestion(mismatch=mismatch, cj_code=cj_code)
                fixed = fix_code(java_target_code, cj_code, "runtime_mismatch", suggestion,
                                 java_out_ok=str(java_out or ""), cj_out_bad=str(cj_out or ""))

            iter_code_path = os.path.join(case_dir, f"cj_target_translation_iter{k}.cj")
            write_to_file(iter_code_path, fixed)

            write_to_file(iter_log, f"### LLM ERROR ANALYSIS SUGGESTIONS ###\n{suggestion}\n\n### FIXED CODE ###\n{fixed}")

            status, compile_out, cj_out, java_out, merged = evaluate(fixed)

            case_record["iterations"].append({
                "iter": k,
                "suggestion": suggestion,
                "status_after_fix": status,
                "cj_run_out": None if cj_out is None else str(cj_out),
                "java_run_out": None if java_out is None else str(java_out)
            })

            if args.debug:
                print(f"[{case_name}] Iter={k}, Status={status}")
            if status == "pass":
                break

        case_record["final_status"] = status
        summary["cases"].append(case_record)

    out_json = os.path.join(args.input, f"repair_summary_{datetime.now().strftime('%m%d_%H%M')}.json")
    with open(out_json, "w", encoding="utf-8") as f:
        json.dump(summary, f, indent=2, ensure_ascii=False)

    print("\n=== Repair Completed ===")
    print(f"Input root: {args.input}")
    print(f"Cases: {len(case_dirs)}")
    print(f"Summary file: {out_json}")
    print("Final status distribution:", {c['final_status'] for c in summary['cases']})


if __name__ == "__main__":
    main()
