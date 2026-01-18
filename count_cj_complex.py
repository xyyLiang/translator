import os
import re
from pathlib import Path


def count_code_lines(file_path):
    try:
        with open(file_path, 'r', encoding='utf-8') as f:
            lines = f.readlines()
        code_lines = 0
        in_block_comment = False
        for line in lines:
            stripped = line.strip()
            if not stripped:
                continue
            if in_block_comment:
                if '*/' in stripped:
                    in_block_comment = False
                    after_comment = stripped.split('*/', 1)[1].strip()
                    if after_comment and not after_comment.startswith('//'):
                        code_lines += 1
                continue
            if stripped.startswith('//'):
                continue
            if '/*' in stripped:
                in_block_comment = True
                before_comment = stripped.split('/*', 1)[0].strip()
                if before_comment and not before_comment.startswith('//'):
                    code_lines += 1
                if '*/' in stripped:
                    in_block_comment = False
                    after_comment = stripped.split('*/', 1)[1].strip()
                    if after_comment and not after_comment.startswith('//'):
                        code_lines += 1
                continue
            code_lines += 1

        return code_lines
    except Exception as e:
        print(f"Error reading {file_path}: {str(e)}")
        return 0

def count_cj_files_lines(directory):
    directory_path = Path(directory)
    if not directory_path.exists():
        print(f"Error: Directory '{directory}' does not exist")
        return {}
    cj_files = list(directory_path.rglob("*.cj"))

    if not cj_files:
        print(f"No .cj files found in {directory}")
        return {}

    print(f"Found {len(cj_files)} .cj files")

    file_line_counts = {}
    for cj_file in cj_files:
        line_count = count_code_lines(cj_file)
        file_line_counts[str(cj_file)] = line_count

    return file_line_counts

def find_files_with_few_lines(file_line_counts, threshold=5):
    few_lines_files = {}

    for file_path, line_count in file_line_counts.items():
        if line_count < threshold:
            few_lines_files[file_path] = line_count

    return few_lines_files

def save_results_to_file(few_lines_files, output_file="few_lines_report.txt"):
    with open(output_file, 'w', encoding='utf-8') as f:
        f.write("Files with fewer than 5 lines of code:\n")
        f.write("=" * 50 + "\n\n")

        for file_path, line_count in sorted(few_lines_files.items()):
            f.write(f"{file_path}: {line_count} lines\n")

    print(f"Report saved to {output_file}")

def analyze_line_distribution(file_line_counts):
    distribution = {
        "1-4 lines": 0,
        "5-10 lines": 0,
        "11-20 lines": 0,
        "21-50 lines": 0,
        "51+ lines": 0
    }
    for line_count in file_line_counts.values():
        if line_count <= 4:
            distribution["1-4 lines"] += 1
        elif line_count <= 10:
            distribution["5-10 lines"] += 1
        elif line_count <= 20:
            distribution["11-20 lines"] += 1
        elif line_count <= 50:
            distribution["21-50 lines"] += 1
        else:
            distribution["51+ lines"] += 1
    return distribution
