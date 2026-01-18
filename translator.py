from openai import OpenAI
from typing import List, Optional, Dict

class Translator:
    def __init__(self, model_name: str) -> None:

        self.model_name = model_name
        self.client = OpenAI(
        )
    def chat(self,
             messages: List[Dict[str, str]],
             max_tokens: int = 2048,
             temperature: Optional[float] = None,
             top_p: Optional[float] = None) -> str:

        response = self.client.chat.completions.create(
            model=self.model_name,
            messages=messages,
            max_tokens=max_tokens,
            temperature=temperature or 0.7,
            top_p=top_p or 1.0,
            stream=False,
            extra_body={"enable_thinking": False}
        )
        return response.choices[0].message.content.strip()

    def translate(self,
                  source_code: str,
                  source_lang: str = "java",
                  mode: str = "zeroshot",
                  ast_text: str = "",
                  temperature: Optional[float] = None,
                  top_p: Optional[float] = None) -> str:

        messages = [
            {"role": "system", "content": "You are a helpful assistant that translates programming code."},
            {"role": "user", "content": f"Please convert the following {source_lang} code into Cangjie programming language, only return the code, no additional explanation is required."
             },
            {"role": "assistant", "content": "OK, I will help you translate."}
        ]

        if mode in ["fewshot", "oneshot"]:
            few_shot_num = 1 if mode == "oneshot" else 2
            messages.extend(JAVA_EXAMPLES[:few_shot_num * 2])

        if ast_text.strip():
            messages.append({
                "role": "user",
                "content": f"The following is the Abstract Syntax Tree (AST) tokens of the Java code:\n{ast_text}\nNow please translate the following {source_lang} code into Cangjie:\n{source_code}"
            })
        else:
            messages.append({"role": "user", "content": f"Please convert the following {source_lang} code into Cangjie programming language, only return the code, no additional explanation is required."
                                                        f"Preserve function names and parameter structures exactly."
                             })

        return self.chat(messages, temperature=temperature, top_p=top_p)
