import json
import os
import glob
import argparse
from datetime import datetime
from ftplib import all_errors

import tqdm

from utils.file_utils import read_file
from utils.bash_utils import remove_color_codes
from compile.cj_compiler import compile_and_run_cj_single
from compile.cj_check import check_cj_from_file,parse_error_messages, parse_error

def main():
    parser = argparse.ArgumentParser(description="批量检查Cangjie代码编译结果")
    parser.add_argument("--input", type=str, required=True, help="")
    args = parser.parse_args()

    files = glob.glob(os.path.join(args.input, "*/cj_target_translation.cj"))

    error_num = 0
    correct_num = 0
    error_paths = []
    correct_paths = []
    except_main_errors = []

    for cj_file in tqdm.tqdm(files):
        cj_code = open(cj_file, "r", encoding="utf8").read() 
        if "main(" not in cj_code:
            cj_code += "\n\nmain(){\n   return 0\n}\n"
        temp_file = os.path.join(os.path.dirname(cj_file), "cj_temp_main.cj")
        with open(temp_file, "w", encoding="utf8") as f:
            f.write(cj_code)

        compile_output = check_cj_from_file(temp_file)
        compile_output = remove_color_codes(compile_output)

        if "error" in compile_output:
            errors = parse_error_messages(compile_output)
            for error in errors:
                error_msg, error_file, error_row, error_col, error_details = parse_error(error)
                print(f"编译失败: {cj_file}")
                print(f"错误信息: {error_msg}")
                print(f"文件: {error_file}, 行: {error_row}, 列: {error_col}")
                print(f"详细信息: {error_details}")

                try:
                    except_main_errors.append({
                        "file": str(cj_file),
                        "error_msg": str(error_msg) if error_msg is not None else None,
                        "error_file": str(error_file) if error_file is not None else None,
                        "row": int(error_row) if error_row is not None else None,
                        "col": int(error_col) if error_col is not None else None,
                        "details": str(error_details) if error_details is not None else None
                    })
                except Exception as e:
                    print(f"JSON 写入失败：{e}")
                    print(f"出错内容预览：{repr(all_errors[-1])}")

            error_num += 1
            error_paths.append(cj_file)
        else:
            correct_num += 1
            correct_paths.append(cj_file)

    print(f"编译失败数量: {error_num}")
    print(f"编译成功数量: {correct_num}")
    print(f"总数: {error_num + correct_num}")

    date_str = datetime.now().strftime("%m%d")
    input_name = os.path.basename(args.input.strip("/").strip("\\"))
    error_filename = f"{input_name}_errors_{date_str}.json"
    with open(error_filename, "w", encoding="utf8") as f:
       json.dump(except_main_errors, f, indent=2, ensure_ascii=False)
    print(f"错误信息已保存至 {error_filename}")

if __name__ == "__main__":
    main()
