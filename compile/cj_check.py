import re
import subprocess
from typing import List, Tuple
import os

FRONTEND_PATH = r"F:\cjc-frontend.exe"

def check_cj_from_file(code_path: str) -> str:
    try:
        output = subprocess.check_output(
            f'"{FRONTEND_PATH}" "{code_path}"',
            shell=True, stderr=subprocess.STDOUT, universal_newlines=True, timeout=30
        )
    except subprocess.CalledProcessError as e:
        return e.output

    if "[Rebuilt Program]" in output:
        end_pos = output.index("[Rebuilt Program]")
        output = output[:end_pos]
    return output

def parse_error_messages(text: str)-> List[str]:
    errors = []
    current_error = None
    for line in text.splitlines():
        if line.startswith("error:") or line.startswith("note:") or line.startswith("warning:"):
            if current_error is not None:
                errors.append(current_error)
            current_error = ""
            current_error += line + "\n"
        else:
            if current_error is not None:
                current_error += line + "\n"
    if current_error is not None:
        errors.append(current_error)
    return errors

def parse_error(error: str)-> Tuple[str|None, str|None, str|None, str|None, str|None]:
    lines = error.splitlines()
    if len(lines) < 2:
        print(error)
        return None, None, None, None, None
    error_msg_line = lines[0]  
    error_pos_line = lines[1]  
    error_details = "\n".join(lines[2:])  

    match = re.search(r"(?:error|note|warning): (.*)", error_msg_line)
    if match:
        error_msg = match.group(1)
    else:
        error_msg = None

    match = re.search(r"==> (.*?.cj):([0-9]{1,5}):([0-9]{1,5}):", error_pos_line)
    if match:
        error_file = match.group(1)
        error_row = int(match.group(2))
        error_col = int(match.group(3))
    else:
        error_file = None
        error_row = None
        error_col = None
    return error_msg, error_file, error_row, error_col, error_details