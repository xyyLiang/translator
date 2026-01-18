from typing import List, Dict, Optional
from error_parser import ErrorInfo
from rag_retriever import RetrievedCase


class PromptBuilder:
    def __init__(self, 
                 max_prompt_length: int = 6000,
                 include_examples: bool = True):
        self.max_prompt_length = max_prompt_length
        self.include_examples = include_examples

        self.templates = {
            'system': self._get_system_template(),
            'with_rag': self._get_rag_template(),
            'without_rag': self._get_basic_template()
        }
    
    def _get_system_template(self) -> str:
        return """You are a precise Cangjie code fixer with extensive experience in Java to Cangjie translation.
Your task is to analyze the current error, infer the repair transformation pattern,and produce the corrected and compilable Cangjie code.
Return ONLY valid, compilable Cangjie code without any explanations or markdown formatting."""
    
    def _get_rag_template(self) -> str:
        return """# Task: Fix Cangjie Compilation Errors

## How to Use the Reference Fix Cases
- You MUST identify the differences in the code before and after repair, learn repair patterns from these cases.
- Apply similar repair method to the current code.
- Do NOT copy the reference code directly.

## Reference Fix Cases
{similar_cases}
      
## Current Error Information
{current_errors}

## Java Source Code (Original)
```java
{java_code}
```

## Cangjie Code (Current - with errors)
```cangjie
{cangjie_code}
```

## Fix Requirements
1. Output ONLY compilable Cangjie code (no markdown fences like ```cangjie)
2. Keep function name 'f_gold' and parameter structure unless necessary to change
3. Do NOT add 'static' modifier to function declarations
4. Please fix based on similar errors and repair cases in # # Current Error Information
5. Apply the MINIMAL NECESSARY MODIFICATION to fix the error. Do NOT rewrite unrelated logic.
6. Follow the Java code logic. Do NOT modify the existing data structure and expression logic at will, unless the error message directly requires it.

Please provide the corrected Cangjie code:"""
    
    def _get_basic_template(self) -> str:
        return """# Task: Fix Cangjie Compilation Errors

## Current Error Information
{current_errors}

## Java Source Code (Original)
```java
{java_code}
```

## Cangjie Code (Current - with errors)
```cangjie
{cangjie_code}
```

## Fix Requirements
1. Output ONLY compilable Cangjie code (no markdown fences)
2. Keep function name 'f_gold' and parameter structure unless necessary
3. Do NOT add 'static' modifier to function declarations
4. Analyze the error messages and apply appropriate fixes

Please provide the corrected Cangjie code:"""
    
    def build_prompt(self,
                    current_errors: List[ErrorInfo],
                    java_code: str,
                    cangjie_code: str,
                    retrieved_cases: Optional[List[RetrievedCase]] = None,
                    mode: str = "compile_error") -> Dict[str, str]:
        current_errors_text = self._format_current_errors(current_errors)
        use_rag = retrieved_cases is not None and len(retrieved_cases) > 0
        if use_rag:
            similar_cases_text = self._format_similar_cases(retrieved_cases)
            user_content = self.templates['with_rag'].format(
                similar_cases=similar_cases_text,
                current_errors=current_errors_text,
                java_code=java_code.strip(),
                cangjie_code=cangjie_code.strip()
            )
        else:
            user_content = self.templates['without_rag'].format(
                current_errors=current_errors_text,
                java_code=java_code.strip(),
                cangjie_code=cangjie_code.strip()
            )
        if len(user_content) > self.max_prompt_length:
            user_content = self._truncate_prompt(user_content)
        
        return {
            'system': self.templates['system'],
            'user': user_content
        }
    
    def _format_current_errors(self, errors: List[ErrorInfo]) -> str:
        if not errors:
            return "No specific error information available."
        
        formatted = []
        for i, error in enumerate(errors, 1):
            error_block = [f"### Error {i}: {error.error_type}"]
            error_block.append(f"**Message:** {error.error_message}")
            
            if error.note_message:
                error_block.append(f"**Suggestion:** {error.note_message}")
            
            if error.code_snippet:
                error_block.append(f"**Code snippet:** `{error.code_snippet}`")
            
            formatted.append("\n".join(error_block))
        
        return "\n\n".join(formatted)
    
    def _format_similar_cases(self, cases: List[RetrievedCase]) -> str:
        if not cases:
            return "No similar cases found."
        
        formatted = []
        for i, case in enumerate(cases, 1):
            case_block = [
                f"### Cangjie Code Repair Similar Case {i} (Similarity: {case.similarity:.2f})",
                f"**Error:** {case.error_message}",
                f"**Fix Suggestion:** {case.fix_suggestion}"
            ]
            if self.include_examples and case.error_case and case.correct_case:
                case_block.append("\n**Before (Error):**")
                case_block.append(f"```cangjie\n{case.error_case.strip()}\n```")
                case_block.append("\n**After (Fixed):**")
                case_block.append(f"```cangjie\n{case.correct_case.strip()}\n```")
            
            formatted.append("\n".join(case_block))
        
        return "\n\n".join(formatted)
    
    def _truncate_prompt(self, prompt: str) -> str:
        if len(prompt) <= self.max_prompt_length:
            return prompt
        
        print(f"[Prompt] prompt is too long: ({len(prompt)}")

        if "**Before (Error):**" in prompt:
            import re
            prompt = re.sub(r'\*\*Before \(Error\):\*\*.*?\*\*After \(Fixed\):\*\*.*?```', 
                          '', prompt, flags=re.DOTALL)
            print(f"[Prompt] move case: {len(prompt)}")
        
        if len(prompt) > self.max_prompt_length:
            lines = prompt.split('\n')
            keep_lines = int(len(lines) * 0.8)
            prompt = '\n'.join(lines[:keep_lines])
            prompt += "\n\n[Note: Content truncated due to length limit]"
            print(f"[Prompt] cutoff: {len(prompt)}")
        
        return prompt[:self.max_prompt_length]
    
    def build_runtime_mismatch_prompt(self,
                                     java_code: str,
                                     cangjie_code: str,
                                     java_output: str,
                                     cangjie_output: str,
                                     retrieved_cases: Optional[List[RetrievedCase]] = None) -> Dict[str, str]:
        mismatch_info = f"""### Runtime Output Mismatch

**Expected Output (Java):**
```
{java_output.strip()}
```

**Actual Output (Cangjie):**
```
{cangjie_output.strip()}
```

**Analysis:** The Cangjie code compiles but produces different output than the Java version.
This usually indicates logic errors, incorrect API usage, or data type handling issues.
Check the statements in the Cangjie code that are inconsistent with Java logic (such as missing or more parts without corresponding Java logic)"""
        
        user_content = f"""# Task: Fix Cangjie Runtime Mismatch

{mismatch_info}

## Java Source Code (Reference)
```java
{java_code.strip()}
```
## Cangjie Code (Current - wrong output)
```cangjie
{cangjie_code.strip()}
```
## Fix Requirements
1. Output ONLY the corrected Cangjie code
2. Ensure the output matches the Java version exactly
3. Check for: incorrect loop logic, wrong API calls, type conversion issues
4. Do NOT add 'static' modifier

Please provide the corrected Cangjie code:"""
        
        return {
            'system': self.templates['system'],
            'user': user_content
        }
