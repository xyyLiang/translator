import re
from typing import List, Dict, Optional
from dataclasses import dataclass


@dataclass
class ErrorInfo:
    error_type: str 
    error_message: str  
    note_message: Optional[str] = None  
    line_number: Optional[int] = None  
    code_snippet: Optional[str] = None 
    
    def get_search_key(self) -> str:
        key = self.error_message
        key = re.sub(r"'[^']*'", "'TYPE'", key)
        key = re.sub(r'\d+', 'N', key)
        return key.strip()

class CangJieErrorParser:
    def __init__(self):
        self.error_pattern = re.compile(
            r"error:\s*(.+?)\s*==>.*?:(\d+):\d+:",
            re.MULTILINE | re.DOTALL
        )
        self.note_pattern = re.compile(
            r"#\s*note:\s*(.+?)(?=\n(?:error:|note:|\Z))",
            re.MULTILINE | re.DOTALL
        )
        self.code_snippet_pattern = re.compile(
            r"\|\s*(\d+)\s*\|\s*(.+?)(?=\n\s*\|)",
            re.MULTILINE
        )
    
    def parse(self, compiler_output: str) -> List[ErrorInfo]:
        errors = []
        clean_output = self._remove_ansi_codes(compiler_output)
        error_matches = list(self.error_pattern.finditer(clean_output))
        
        for i, error_match in enumerate(error_matches):
            error_msg = error_match.group(1).strip()
            line_num = int(error_match.group(2))
            note_msg = None
            note_start = error_match.end()
            note_end = error_matches[i + 1].start() if i + 1 < len(error_matches) else len(clean_output)
            note_section = clean_output[note_start:note_end]
            
            note_match = self.note_pattern.search(note_section)
            if note_match:
                note_msg = note_match.group(1).strip()
                        code_snippet = None
            snippet_matches = self.code_snippet_pattern.findall(note_section)
            if snippet_matches:
                code_snippet = snippet_matches[0][1].strip()
            error_type = self._identify_error_type(error_msg)
            
            error_info = ErrorInfo(
                error_type=error_type,
                error_message=error_msg,
                note_message=note_msg,
                line_number=line_num,
                code_snippet=code_snippet
            )
            
            errors.append(error_info)
        
        return errors
    
    def _identify_error_type(self, error_msg: str) -> str:
        error_msg_lower = error_msg.lower()
        type_keywords = {
            'undeclared': 'undeclared_identifier',
            'cannot assign': 'assignment_error',
            'invalid binary operator': 'operator_error',
            'type mismatch': 'type_mismatch',
            'undefined': 'undefined_error',
            'cannot convert': 'conversion_error',
            'immutable': 'immutable_error',
        }
        
        for keyword, error_type in type_keywords.items():
            if keyword in error_msg_lower:
                return error_type
        
        return 'unknown_error'
    
    def _remove_ansi_codes(self, text: str) -> str:
        ansi_escape = re.compile(r'\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])')
        return ansi_escape.sub('', text)
    
    def format_for_display(self, errors: List[ErrorInfo]) -> str:
        output = []
        for i, error in enumerate(errors, 1):
            output.append(f"=== Error {i} ===")
            output.append(f"Type: {error.error_type}")
            output.append(f"Message: {error.error_message}")
            if error.note_message:
                output.append(f"Note: {error.note_message}")
            if error.code_snippet:
                output.append(f"Code: {error.code_snippet}")
            output.append("")
        
        return "\n".join(output)
