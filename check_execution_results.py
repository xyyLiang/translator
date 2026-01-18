import os
import glob
import argparse
import tqdm
import json
from datetime import datetime
from utils.file_utils import read_file, write_to_file
from utils.bash_utils import remove_color_codes
from compile.cj_compiler import compile_and_run_cj, compile_and_run_cj_single
from compile.java_compiler import compile_and_run_java

def have_compilation_error(code: str) -> bool:
    compile_output, cj_output = compile_and_run_cj_single(code)
    if not isinstance(compile_output, str): 
        print(type(compile_output), compile_output)
    cj_compile_output = remove_color_codes(compile_output)
    return len(cj_compile_output.strip()) != 0 and "error" in cj_compile_output

def safe_string(value):
    return str(value) if value is not None else "None"

def main():
    parser = argparse.ArgumentParser(description="Compile and run Cangjie code in batch and compare it with Java results to generate logs")
    parser.add_argument("--input", type=str, required=True, help="")
    parser.add_argument('--test-ground-truth', action='store_true', help="Enable testing of ground truth function")
    parser.add_argument('--debug', action='store_true', help="Enable debug output")
    args = parser.parse_args()

    case_dirs = glob.glob(os.path.join(args.input, "*"))
    total_num = 0
    error_num = 0
    correct_num = 0
    fail_num = 0
    error_records = [] 

    for case_dir in tqdm.tqdm(case_dirs, desc="评测中", ncols=80):
        cj_test_path = os.path.join(case_dir, "cj_test.cj")
        cj_target_translation_path = os.path.join(case_dir, "cj_target_translation.cj")
        cj_target_path = os.path.join(case_dir, "cj_target.cj")
        java_test_path = os.path.join(case_dir, "java_test.java")
        java_target_path = os.path.join(case_dir, "java_target.java")

        if not (os.path.exists(cj_test_path) and os.path.exists(cj_target_translation_path)
                and os.path.exists(java_test_path) and os.path.exists(java_target_path)):
            continue

        total_num += 1

        cj_test_code = read_file(cj_test_path)
        cj_target_trans_code = read_file(cj_target_translation_path)
        cj_target_code = read_file(cj_target_path)
        java_test_code = read_file(java_test_path)
        java_target_code = read_file(java_target_path)

        if not args.test_ground_truth:
            final_cj_code = cj_test_code.replace("//TOFILL", cj_target_trans_code)
        else:
            final_cj_code = cj_test_code.replace("//TOFILL", cj_target_code)

        if have_compilation_error(final_cj_code):
            error_final_path = os.path.join(case_dir, "error_final.txt")
            compile_output, cj_output = compile_and_run_cj_single(final_cj_code)
            compile_output = remove_color_codes(compile_output)
            write_to_file(error_final_path, "\n==========\n".join(["final",final_cj_code,compile_output,"None"]))
            error_num += 1
            print(f"[编译错误] {case_dir}")
            error_records.append({
                "case": case_dir,
                "error_type": "compile",
                "compile_output": compile_output,
                "run_output": None
            })
            continue

        if not args.test_ground_truth:
            cj_compile_output, cj_run_output = compile_and_run_cj(cj_test_code, cj_target_trans_code)
        else:
            cj_compile_output, cj_run_output = compile_and_run_cj(cj_test_code, cj_target_code)
        java_compile_output, java_run_output = compile_and_run_java(java_test_code, java_target_code)
        error_final_path = os.path.join(case_dir, "error_final.txt")
        failure_path = os.path.join(case_dir, "failure.txt")
        pass_path = os.path.join(case_dir, "pass.txt")

        if cj_run_output is None or (isinstance(cj_compile_output, str) and "error" in cj_compile_output):
            error_num += 1
            write_to_file(error_final_path, "\n==========\n".join([
                "final", final_cj_code, safe_string(cj_compile_output), safe_string(cj_run_output)
            ]))
            error_records.append({
                "case": case_dir,
                "error_type": "cangjie_run_failed",
                "compile_output": safe_string(cj_compile_output),
                "run_output": safe_string(cj_run_output)
            })

        elif java_run_output is not None and cj_run_output.strip() == java_run_output.strip():
            correct_num += 1
            write_to_file(pass_path, cj_run_output)
        else:
            fail_num += 1
            error_records.append({
                "case": case_dir,
                "error_type": "not same",
                "compile_output": safe_string(cj_compile_output),
                "run_output": safe_string(cj_run_output)
            })

            if java_run_output is None:
                error_records.append({
                    "case": case_dir,
                    "error_type": "!!! java_run_failed !!!",
                    "compile_output": safe_string(java_compile_output),
                    "run_output": safe_string(java_run_output)
                })
            write_to_file(failure_path, safe_string(java_run_output) + "\n==========\n" + cj_run_output)

        if args.debug:
            print(f"用例: {case_dir}")
            print("Cangjie编译输出:")
            print(safe_string(cj_compile_output))
            print("Cangjie运行输出:")
            print(safe_string(cj_run_output))
            print("Java运行输出:")
            print(safe_string(java_run_output))
            print("=" * 40)

        temp_extensions = [".BC", ".BCHIR2", ".CJO"]
        for ext in temp_extensions:
            for filename in os.listdir(case_dir):
                if filename.endswith(ext):
                    try:
                        os.remove(os.path.join(case_dir, filename))
                    except Exception as e:
                        print(f"无法删除临时文件 {filename}：{e}")

    date_str = datetime.now().strftime("%m%d")
    input_name = os.path.basename(args.input.rstrip("/"))
    error_json_path = f"{input_name}_execution_errors_{date_str}.json"
    with open(error_json_path, "w", encoding="utf-8") as f:
        json.dump(error_records, f, indent=2, ensure_ascii=False)

    print(f"总数: {total_num}")
    print(f"通过: {correct_num}")
    print(f"失败: {fail_num}")
    print(f"编译/运行错误: {error_num}")

if __name__ == "__main__":
    main()
