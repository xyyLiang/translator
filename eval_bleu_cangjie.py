import argparse
import re
from pathlib import Path
from typing import List, Tuple, Dict
import sacrebleu
import pandas as pd


def load_pairs(root_dir: str) -> List[Tuple[str, str, str]]:
    """
    Returns: list of (case_id, pred_code, ref_code)
    case_id is the test folder name.
    """
    root = Path(root_dir)
    if not root.exists():
        raise FileNotFoundError(f"Root dir not found: {root_dir}")
    pairs = []
    for case_dir in sorted(root.iterdir()):
        if not case_dir.is_dir():
            continue

        pred_path = case_dir / "cj_target_translation.cj"
        ref_path = case_dir / "cj_target.cj"
        if not pred_path.exists() or not ref_path.exists():
            continue

        pred = pred_path.read_text(encoding="utf-8", errors="ignore")
        ref = ref_path.read_text(encoding="utf-8", errors="ignore")
        pairs.append((case_dir.name, pred, ref))

    if not pairs:
        raise RuntimeError(
            "No valid test folders found. Expected each subfolder to contain "
            "'cj_target_translation.cj' and 'cj_target.cj'."
        )

    return pairs

_TOKEN_RE = re.compile(
    r"""
    ([A-Za-z_\u0080-\uFFFF][A-Za-z0-9_\u0080-\uFFFF]*)   # identifiers (incl unicode)
    |(\d+\.\d+|\d+)                                      # numbers
    |(==|!=|<=|>=|->|=>|\+\+|--|\|\||&&)                 # multi-char operators
    |([^\s])                                             # any non-space char (punct/operator)
    """,
    re.VERBOSE
)

def code_tokenize(s: str) -> List[str]:
    s = s.replace("\r\n", "\n")
    tokens = []
    for m in _TOKEN_RE.finditer(s):
        tok = next(g for g in m.groups() if g is not None)
        tokens.append(tok)
    return tokens

def to_bleu_sentence(code: str) -> str:
    return " ".join(code_tokenize(code))


def corpus_bleu(preds: List[str], refs: List[str]) -> float:
    preds_tok = [to_bleu_sentence(p) for p in preds]
    refs_tok = [to_bleu_sentence(r) for r in refs]
    bleu = sacrebleu.corpus_bleu(
        preds_tok,
        [refs_tok],
        tokenize="none",
        smooth_method="exp"
    )
    return float(bleu.score) / 100.0

def sentence_bleu(pred: str, ref: str) -> float:
    pred_tok = to_bleu_sentence(pred)
    ref_tok = to_bleu_sentence(ref)
    bleu = sacrebleu.sentence_bleu(
        pred_tok,
        [ref_tok],
        tokenize="none",
        smooth_method="exp"
    )
    return float(bleu.score) / 100.0

def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--root_dir", required=True, help="Root directory containing test folders")
    ap.add_argument("--out_file", default="bleu_results.csv", help="Single output CSV for all cases")
    ap.add_argument("--limit", type=int, default=0, help="Optional: evaluate only first N cases (0=all)")
    args = ap.parse_args()

    pairs = load_pairs(args.root_dir)
    if args.limit and args.limit > 0:
        pairs = pairs[: args.limit]

    case_ids = [cid for cid, _, _ in pairs]
    preds = [p for _, p, _ in pairs]
    refs = [r for _, _, r in pairs]

    # corpus-level BLEU
    bleu_corpus = corpus_bleu(preds, refs)

    print("=== Corpus-level BLEU ===")
    print(f"BLEU = {bleu_corpus:.6f}  (0~1 scale)")
    print(f"BLEU = {bleu_corpus*100:.2f}  (0~100 scale)")
    print(f"Cases evaluated: {len(pairs)}")

    # per-sample BLEU + lengths
    rows: List[Dict] = []
    for cid, p, r in zip(case_ids, preds, refs):
        p_tok = code_tokenize(p)
        r_tok = code_tokenize(r)
        rows.append({
            "case_id": cid,
            "bleu": sentence_bleu(p, r),
            "pred_len_tokens": len(p_tok),
            "ref_len_tokens": len(r_tok),
        })

    df = pd.DataFrame(rows)
    df.to_csv(args.out_file, index=False, encoding="utf-8")
    print(f"\nAll per-case scores saved to: {args.out_file}")


if __name__ == "__main__":
    main()
