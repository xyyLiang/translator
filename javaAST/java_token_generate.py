import os
import sys
import argparse
from typing import Dict, List
import pandas as pd
from tree_sitter import Language, Parser
import tree_sitter_java  

JAVA_LANGUAGE = Language(tree_sitter_java.language())
PARSER = Parser(JAVA_LANGUAGE)

def dfs_named_tokens(code: str, node_type_to_token: Dict[str, str]) -> List[str]:
    tree = PARSER.parse(code.encode("utf-8", errors="ignore"))
    root = tree.root_node
    tokens: List[str] = []

    def walk(node):
        if node.is_named:
            t = node.type
            tok = node_type_to_token.get(t)
            if tok:
                tokens.append(tok)
        for child in node.named_children:
            walk(child)

    walk(root)
    return tokens

def iter_parallel_java_files(base_dir: str):
    for folder_name in os.listdir(base_dir):
        subdir_path = os.path.join(base_dir, folder_name)
        if not os.path.isdir(subdir_path):
            continue
        java_path = os.path.join(subdir_path, "java_target.java")
        if os.path.isfile(java_path):
            yield folder_name, subdir_path, java_path


def list_missing_java_dirs(base_dir: str):
    missing = []
    for folder_name in os.listdir(base_dir):
        subdir_path = os.path.join(base_dir, folder_name)
        if not os.path.isdir(subdir_path):
            continue
        java_path = os.path.join(subdir_path, "java_target.java")
        if not os.path.isfile(java_path):
            missing.append(os.path.abspath(subdir_path))
    return missing

def main():
    ap = argparse.ArgumentParser(
        description="generate ast_tokens data"
    )
    ap.add_argument("--base_dir", type=str, default=r"G:\Java2Cangjie\test_case",help="")
    ap.add_argument("--mapping_csv", type=str, default=r"G:\Java2Cangjie\AST_analyse\AST_token\java_ast_node_mapping.csv",help="")
    ap.add_argument("--out_filename", type=str, default="ast_tokens.txt",help="")
    args = ap.parse_args()

    if not os.path.isdir(args.base_dir):
        print(f"[ERROR] dont have: {args.base_dir}", file=sys.stderr)
        sys.exit(1)

    if not os.path.isfile(args.mapping_csv):
        print(f"[ERROR] dont have: {args.mapping_csv}", file=sys.stderr)
        sys.exit(1)

    df = pd.read_csv(args.mapping_csv)
    cols = {c.lower(): c for c in df.columns}
    if "node_type" not in cols or "mapped_token" not in cols:
        print("[ERROR] dont have: node_type, mapped_token", file=sys.stderr)
        sys.exit(1)
    node_type_col = cols["node_type"]
    mapped_col = cols["mapped_token"]

    node2tok: Dict[str, str] = {}
    for _, row in df.iterrows():
        nt = str(row[node_type_col]).strip()
        mt = str(row[mapped_col]).strip()
        if nt and mt:
            node2tok[nt] = mt

    total_files, ok_files, fail_files = 0, 0, 0
    for name, subdir, java_path in iter_parallel_java_files(args.base_dir):
        total_files += 1
        try:
            with open(java_path, "r", encoding="utf-8", errors="ignore") as f:
                code = f.read()
            seq = dfs_named_tokens(code, node2tok)
            if seq:
                seq_out = ["<AST_BEGIN>"] + seq + ["<AST_END>"]
            else:
                seq_out = ["<AST_BEGIN>", "<AST_END>"]

            out_path = os.path.join(subdir, args.out_filename)
            with open(out_path, "w", encoding="utf-8") as wf:
                wf.write(" ".join(seq_out) + "\n")

            ok_files += 1
        except Exception as e:
            fail_files += 1
            print(f"[WARN] error: {java_path} -> {e}", file=sys.stderr)

    missing_dirs = list_missing_java_dirs(args.base_dir)

    if missing_dirs:
        print("[MISSING PATHS]")
        for p in missing_dirs:
            print(p)
