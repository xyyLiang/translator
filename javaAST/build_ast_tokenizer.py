import os, sys, argparse, csv, re
from transformers import AutoTokenizer

def read_text_utf8(path):
    with open(path, "rb") as f:
        raw = f.read()
    try:
        return raw.decode("utf-8-sig")
    except UnicodeDecodeError:
        return raw.decode("utf-8", errors="ignore")

def load_mapped_tokens(csv_path):
    if not os.path.isfile(csv_path):
        print(f"[ERROR] dont have:: {csv_path}", file=sys.stderr)
        sys.exit(1)
    text = read_text_utf8(csv_path)
    reader = csv.DictReader(text.splitlines(), delimiter=",")
    cols_lower = [c.lower().strip() for c in reader.fieldnames or []]
    if "mapped_token" not in cols_lower:
        tokens = re.findall(r"<AST[_\.A-Za-z0-9\-]+?>", text)
        if not tokens:
            print("[ERROR] dont have: mapped_token", file=sys.stderr)
            sys.exit(1)
        return sorted(set(tokens))
    key = reader.fieldnames[cols_lower.index("mapped_token")]
    toks = []
    for row in reader:
        v = (row.get(key) or "").strip()
        if v:
            toks.append(v)
    toks = sorted(set(toks))
    for must in ("<AST_BEGIN>", "<AST_END>"):
        if must not in toks:
            toks = [must] + toks
    return toks

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--base_model", required=True)
    ap.add_argument("--mapping_csv", required=True)
    ap.add_argument("--save_dir", required=True)
    args = ap.parse_args()

    os.makedirs(args.save_dir, exist_ok=True)
    special_tokens = load_mapped_tokens(args.mapping_csv)

    print(f"[INFO]  special tokens : {len(special_tokens)}")
    tok = AutoTokenizer.from_pretrained(args.base_model, use_fast=True)
    added = tok.add_special_tokens({"additional_special_tokens": special_tokens})
    if hasattr(tok, "unique_no_split_tokens"):
        tok.unique_no_split_tokens = list(set(tok.unique_no_split_tokens + special_tokens))
    tok.save_pretrained(args.save_dir)
    print(f"[OK]  tokenizer -> {args.save_dir}, {added} tokens")
    bad = []
    for t in special_tokens:
        ids = tok.encode(t, add_special_tokens=False)
        if len(ids) != 1:
            bad.append((t, ids))
    if bad:
        print("[WARN] special tokens）:", file=sys.stderr)
        for t, ids in bad[:30]:
            print("   ", t, "->", ids, file=sys.stderr)
    else:
        print("[CHECK] only ID ")
