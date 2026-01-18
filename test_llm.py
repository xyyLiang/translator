import os
import glob
import shutil
import argparse
import tqdm  
from translator import Translator
from utils.file_utils import read_file, write_to_file


def main():
    parser = argparse.ArgumentParser(description="Run baseline Java to Cangjie translation.")
    parser.add_argument("--input", type=str, required=True, help="Path to test_case folder")
    parser.add_argument("--output", type=str, required=True, help="Root path to save results")
    parser.add_argument("--model", type=str, default="LLAMA3-1", help="LLM model name")
    parser.add_argument("--mode", type=str, default="zeroshot", choices=["zeroshot", "oneshot", "fewshot"], help="Translation mode")
    args = parser.parse_args()

    dataset_name = os.path.basename(os.path.abspath(args.input))
    output_dir = os.path.join(args.output, f"baseline_{dataset_name}_{args.mode}_{args.model}")

    os.makedirs(output_dir, exist_ok=True)

    translator = Translator(model_name=args.model)

    case_dirs = glob.glob(os.path.join(args.input, "*"))

    for case_dir in tqdm.tqdm(case_dirs, desc="Translating", ncols=80):
        if not os.path.isdir(case_dir):
            continue
        case_name = os.path.basename(case_dir)
        output_case_dir = os.path.join(output_dir, case_name)
        os.makedirs(output_case_dir, exist_ok=True)
        java_target = os.path.join(case_dir, "java_target.java")
        java_test = os.path.join(case_dir, "java_test.java")
        cj_target = os.path.join(case_dir, "cj_target.cj")
        cj_test = os.path.join(case_dir, "cj_test.cj")
        cj_translation = os.path.join(output_case_dir, "cj_target_translation.cj")

        for file in [java_target, java_test, cj_target, cj_test]:
            if os.path.exists(file):
                shutil.copy(file, output_case_dir)

        # 翻译 Java -> Cangjie
        if os.path.exists(java_target):
            java_code = read_file(java_target)

            # AST提示
            ast_path = os.path.join(case_dir, "ast_tokens.txt")
            ast_text = ""
            if os.path.exists(ast_path):
                ast_text = read_file(ast_path)
            translation = translator.translate(source_code=java_code, source_lang="java", mode=args.mode,ast_text = ast_text)

            if translation.startswith("```"):
                translation = translation.strip("`").split("\n", 1)[1] if "\n" in translation else translation

            write_to_file(cj_translation, translation)
            print(f"[✓] Translated: {case_name}")

    print(f"\n{output_dir}")
