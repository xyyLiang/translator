import pandas as pd
import numpy as np
from typing import List, Dict, Tuple, Optional, Set
from dataclasses import dataclass
import re
from collections import Counter
import math
import heapq
from difflib import SequenceMatcher


@dataclass
class RetrievedCase:
    error_message: str
    fix_suggestion: str  
    error_case: str 
    correct_case: str  
    similarity: float  
    tags: Optional[str] = None  
    match_details: Optional[Dict] = None  


class RAGRetriever:
    def __init__(self,
                 excel_path: str,
                 similarity_threshold: float = 0.25,
                 top_k: int = 3):
        self.excel_path = excel_path
        self.similarity_threshold = similarity_threshold
        self.top_k = top_k
        self._init_programming_keywords()
        self.cases_df = self._load_cases()

        if len(self.cases_df) > 0:
            self._preprocess_cases()
            self._build_enhanced_vocabulary()
            self._precompute_tfidf()

    def _init_programming_keywords(self):
        self.programming_keywords = {
            'Int32', 'Int64', 'Float64', 'Float32', 'String', 'Char', 'Rune', 'Bool',
            'Byte', 'UInt32', 'UInt64', 'ArrayList', 'Array', 'HashMap', 'HashSet',
            'func', 'var', 'let', 'const', 'public', 'private', 'static', 'final',
            'if', 'else', 'for', 'while', 'return', 'import', 'class', 'struct',
            'append', 'add', 'put', 'get', 'remove', 'size', 'contains', 'insert',
            'charAt', 'peek', 'pop', 'push', 'toUpperCase', 'toLowerCase',
            'sqrt', 'abs', 'min', 'max', 'sort',
            'operator', 'assign', 'convert', 'cast', 'declare', 'define',
            'immutable', 'mutable', 'parameter', 'argument'
        }

        self.error_type_hierarchy = {
            'assignment_error': {'immutable_assignment', 'variable_assignment'},
            'type_error': {'type_mismatch', 'undeclared_type', 'conversion_error'},
            'operator_error': {'invalid_operator', 'no_match_function'},
            'identifier_error': {'undeclared_identifier', 'undefined_reference'},
            'method_error': {'non_member_method', 'incorrect_method'}
        }

    def _load_cases(self) -> pd.DataFrame:
        try:
            df = pd.read_excel(self.excel_path)
            required_columns = ['Error_Message', 'Fix_Suggestion',
                                'Error_Case', 'Correct_Case']
            missing = [col for col in required_columns if col not in df.columns]
            if missing:
                raise ValueError(f"Excel miss: {missing}")
            df = df.fillna("")

            print(f"[RAG]  {len(df)} ")
            return df

        except Exception as e:
            print(f"[RAG] error: {e}")
            return pd.DataFrame(columns=['Error_Message', 'Fix_Suggestion',
                                         'Error_Case', 'Correct_Case', 'Tags'])

    def _preprocess_cases(self):
        self.cases_df['error_type'] = self.cases_df['Error_Message'].apply(
            self._extract_enhanced_error_type
        )

        self.cases_df['key_terms'] = self.cases_df['Error_Message'].apply(
            self._extract_enhanced_key_terms
        )
        self.cases_df['code_features'] = self.cases_df.apply(
            lambda row: self._extract_code_features(row['Error_Case'], row['Correct_Case']),
            axis=1
        )
        self.cases_df['combined_text'] = (
                self.cases_df['Error_Message'] + " " +
                self.cases_df['Fix_Suggestion'] + " " +
                self.cases_df['Tags'].fillna("")
        )

    def _extract_enhanced_error_type(self, error_msg: str) -> str:
        error_msg_lower = error_msg.lower()
        error_patterns = [
            (r'cannot assign to immutable', 'immutable_assignment'),
            (r'variable.*immutable', 'immutable_assignment'),
            (r'undeclared type name', 'undeclared_type'),
            (r'mismatched types', 'type_mismatch'),
            (r'cannot convert', 'type_conversion'),
            (r'expected.*found', 'type_expected_found'),
            (r'undeclared identifier', 'undeclared_identifier'),
            (r'undefined reference', 'undefined_reference'),
            (r'invalid binary operator', 'invalid_operator'),
            (r'no matching function.*operator', 'no_match_operator'),
            (r'is not a member of', 'non_member_method'),
            (r'no matching function', 'no_match_function'),
            (r'extra argument', 'extra_argument'),
            (r'missing argument', 'missing_argument'),
            (r'unexpected modifier', 'unexpected_modifier'),
            (r'expected.*in.*expression', 'syntax_error'),
            (r'in.*scope', 'scope_error'),
            (r'ambiguous', 'ambiguous_call'),
            (r'cannot.*on type', 'type_operation_error'),
        ]

        for pattern, error_type in error_patterns:
            if re.search(pattern, error_msg_lower):
                return error_type

        return 'unknown_error'

    def _extract_enhanced_key_terms(self, text: str) -> List[str]:
        quoted_terms = re.findall(r"'([^']+)'", text)
        double_quoted = re.findall(r'"([^"]+)"', text)
        backtick_terms = re.findall(r'`([^`]+)`', text)
        found_keywords = []
        for keyword in self.programming_keywords:
            if re.search(r'\b' + re.escape(keyword) + r'\b', text, re.IGNORECASE):
                found_keywords.append(keyword)
        camel_case = re.findall(r'[a-z]+[A-Z][a-zA-Z]*', text)
        snake_case = re.findall(r'[a-z]+_[a-z]+', text)

        all_terms = quoted_terms + double_quoted + backtick_terms + found_keywords + camel_case + snake_case

        cleaned_terms = []
        for term in all_terms:
            term = term.strip()
            if len(term) > 1 and term not in cleaned_terms:
                cleaned_terms.append(term)

        return cleaned_terms

    def _extract_code_features(self, error_case: str, correct_case: str) -> Dict:
        features = {}
        func_match = re.search(r'func\s+(\w+)\s*\(([^)]*)\)', error_case)
        if func_match:
            features['function_name'] = func_match.group(1)
            features['parameters'] = func_match.group(2)
        types_used = re.findall(r'(?:Int32|Int64|Float64|String|Rune|Bool|ArrayList|HashMap|HashSet)\b', error_case)
        features['types_used'] = list(set(types_used))
        method_calls = re.findall(r'\.(\w+)\s*\(', error_case)
        features['method_calls'] = list(set(method_calls))
        features['code_similarity'] = SequenceMatcher(None, error_case, correct_case).ratio()

        return features

    def _build_enhanced_vocabulary(self):
        all_terms = set()
        for _, row in self.cases_df.iterrows():
            error_terms = self._tokenize_enhanced(row['Error_Message'])
            fix_terms = self._tokenize_enhanced(row['Fix_Suggestion'])
            tag_terms = self._tokenize_enhanced(row.get('Tags', ''))

            all_terms.update(error_terms + fix_terms + tag_terms)
        all_terms.update(self.programming_keywords)
        self.vocabulary = sorted(all_terms)
        self.vocab_index = {term: idx for idx, term in enumerate(self.vocabulary)}
        self.vocab_size = len(self.vocabulary)

        print(f"[RAG] all {self.vocab_size} ")

    def _tokenize_enhanced(self, text: str) -> List[str]:
        if not text:
            return []
        quoted_terms = re.findall(r"'([^']+)'", text)
        code_terms = re.findall(r'`([^`]+)`', text)
        text_clean = re.sub(r"'[^']+'", ' ', text)
        text_clean = re.sub(r'`[^`]+`', ' ', text_clean)
        words = re.findall(r'[a-zA-Z_][a-zA-Z0-9_.]*', text_clean)
        stopwords = {
            'a', 'an', 'the', 'is', 'are', 'was', 'were', 'be', 'been',
            'have', 'has', 'had', 'do', 'does', 'did', 'will', 'would',
            'should', 'could', 'may', 'might', 'can', 'to', 'of', 'in',
            'on', 'at', 'for', 'with', 'by', 'from', 'as', 'and', 'or'
        }
        filtered_words = [w for w in words if w.lower() not in stopwords and len(w) > 1]
        all_terms = quoted_terms + code_terms + filtered_words
        return list(set(all_terms))

    def _precompute_tfidf(self):
        n_docs = len(self.cases_df)
        if n_docs == 0:
            self.tfidf_matrix = np.array([])
            return
        df = Counter()
        tf_matrix = np.zeros((n_docs, self.vocab_size))

        for doc_idx, row in self.cases_df.iterrows():
            terms = self._tokenize_enhanced(row['combined_text'])
            term_freq = Counter(terms)
            total_terms = max(len(terms), 1) 

            for term, freq in term_freq.items():
                if term in self.vocab_index:
                    vocab_idx = self.vocab_index[term]
                    tf_matrix[doc_idx, vocab_idx] = freq / total_terms
                    df[term] += 1
        idf_vector = np.zeros(self.vocab_size)
        for term, doc_freq in df.items():
            if term in self.vocab_index:
                idx = self.vocab_index[term]
                idf_vector[idx] = math.log((n_docs + 1) / (doc_freq + 1)) + 1
        self.tfidf_matrix = tf_matrix * idf_vector
        self.doc_norms = np.linalg.norm(self.tfidf_matrix, axis=1)

        print(f"[RAG] TF-IDF: {self.tfidf_matrix.shape}")

    def _calculate_error_type_similarity(self, query_type: str, case_type: str) -> float:
        if query_type == case_type:
            return 1.0
        for category, types in self.error_type_hierarchy.items():
            if query_type in types and case_type in types:
                return 0.7  
        query_base = query_type.split('_')[0]
        case_base = case_type.split('_')[0]
        if query_base == case_base:
            return 0.5
        return 0.0

    def _calculate_code_similarity(self, query_features: Dict, case_features: Dict) -> float:
        score = 0.0
        features_compared = 0
        if 'function_name' in query_features and 'function_name' in case_features:
            q_func = query_features['function_name']
            c_func = case_features['function_name']
            if q_func and c_func:
                score += SequenceMatcher(None, q_func, c_func).ratio()
                features_compared += 1

        if 'types_used' in query_features and 'types_used' in case_features:
            q_types = set(query_features['types_used'])
            c_types = set(case_features['types_used'])
            if q_types and c_types:
                overlap = len(q_types & c_types) / len(q_types | c_types)
                score += overlap
                features_compared += 1

        if 'method_calls' in query_features and 'method_calls' in case_features:
            q_methods = set(query_features['method_calls'])
            c_methods = set(case_features['method_calls'])
            if q_methods and c_methods:
                overlap = len(q_methods & c_methods) / len(q_methods | c_methods)
                score += overlap
                features_compared += 1

        return score / features_compared if features_compared > 0 else 0.0

    def retrieve(self,
                 error_message: str,
                 note_message: Optional[str] = None,
                 code_context: Optional[str] = None) -> List[RetrievedCase]:
        if len(self.cases_df) == 0:
            print("[RAG] error")
            return []
        query_text = error_message
        if note_message:
            query_text += " " + note_message
        query_error_type = self._extract_enhanced_error_type(error_message)
        query_key_terms = self._extract_enhanced_key_terms(query_text)
        query_code_features = self._extract_code_features(code_context or "", "") if code_context else {}

        similarities = []
        for idx, row in self.cases_df.iterrows():
            sim_score, match_details = self._calculate_enhanced_similarity(
                query_text=query_text,
                query_error_type=query_error_type,
                query_key_terms=query_key_terms,
                query_code_features=query_code_features,
                case_idx=idx,
                case_row=row
            )

            similarities.append((idx, sim_score, match_details))

        if len(similarities) > self.top_k:
            top_indices = heapq.nlargest(self.top_k, similarities, key=lambda x: x[1])
        else:
            top_indices = similarities

        filtered = [(idx, score, details) for idx, score, details in top_indices
                    if score >= self.similarity_threshold]
        results = []
        for idx, score, details in filtered:
            row = self.cases_df.iloc[idx]
            case = RetrievedCase(
                error_message=row['Error_Message'],
                fix_suggestion=row['Fix_Suggestion'],
                error_case=row['Error_Case'],
                correct_case=row['Correct_Case'],
                similarity=score,
                tags=row.get('Tags', None),
                match_details=details
            )
            results.append(case)

        print(f"[RAG] retrive {len(results)} case ({self.similarity_threshold})")
        for i, case in enumerate(results, 1):
            print(f"  case {i}: similarity={case.similarity:.3f}")

        return results

    def _calculate_enhanced_similarity(self,
                                       query_text: str,
                                       query_error_type: str,
                                       query_key_terms: List[str],
                                       query_code_features: Dict,
                                       case_idx: int,
                                       case_row: pd.Series) -> Tuple[float, Dict]:

        match_details = {}

        case_error_type = case_row['error_type']
        error_type_sim = self._calculate_error_type_similarity(query_error_type, case_error_type)
        match_details['error_type_similarity'] = error_type_sim
        match_details['query_error_type'] = query_error_type
        match_details['case_error_type'] = case_error_type

        case_key_terms = case_row['key_terms']
        query_terms_set = set(term.lower() for term in query_key_terms)
        case_terms_set = set(term.lower() for term in case_key_terms)

        intersection = set()
        if query_terms_set and case_terms_set:
            intersection = query_terms_set & case_terms_set
            union = query_terms_set | case_terms_set
            term_score = len(intersection) / len(union)
        else:
            term_score = 0.0

        match_details['matched_terms'] = list(intersection)
        match_details['term_score'] = term_score

        query_terms = self._tokenize_enhanced(query_text)
        query_tfidf = self._compute_query_tfidf_optimized(query_terms)
        case_tfidf = self.tfidf_matrix[case_idx]

        dot_product = np.dot(query_tfidf, case_tfidf)
        query_norm = np.linalg.norm(query_tfidf)
        case_norm = self.doc_norms[case_idx] if case_idx < len(self.doc_norms) else np.linalg.norm(case_tfidf)

        if query_norm > 0 and case_norm > 0:
            cosine_sim = dot_product / (query_norm * case_norm)
        else:
            cosine_sim = 0.0

        match_details['cosine_similarity'] = cosine_sim

        case_code_features = case_row['code_features']
        code_similarity = self._calculate_code_similarity(query_code_features, case_code_features)
        match_details['code_similarity'] = code_similarity

        ngram_score = self._ngram_similarity_improved(query_text, case_row['Error_Message'])
        match_details['ngram_score'] = ngram_score

        edit_similarity = SequenceMatcher(None, query_text.lower(), case_row['Error_Message'].lower()).ratio()
        match_details['edit_similarity'] = edit_similarity

        # === Weighted combination ===
        weights = {
            'error_type': 0.25,  
            'terms': 0.25, 
            'tfidf': 0.20, 
            'code': 0.15, 
            'ngram': 0.10, 
            'edit': 0.05  
        }

        final_score = (
                weights['error_type'] * error_type_sim +
                weights['terms'] * term_score +
                weights['tfidf'] * cosine_sim +
                weights['code'] * code_similarity +
                weights['ngram'] * ngram_score +
                weights['edit'] * edit_similarity
        )

        match_details['final_score'] = final_score
        match_details['score_breakdown'] = {
            'error_type_sim': error_type_sim,
            'term_score': term_score,
            'cosine_sim': cosine_sim,
            'code_similarity': code_similarity,
            'ngram_score': ngram_score,
            'edit_similarity': edit_similarity
        }

        return final_score, match_details

    def _compute_query_tfidf_optimized(self, query_terms: List[str]) -> np.ndarray:
        query_vector = np.zeros(self.vocab_size)

        if not query_terms:
            return query_vector

        n_docs = len(self.cases_df)
        term_freq = Counter(query_terms)
        total_terms = len(query_terms)

        for term, freq in term_freq.items():
            if term in self.vocab_index:
                vocab_idx = self.vocab_index[term]
                tf = freq / total_terms
                doc_freq = sum(1 for row in self.tfidf_matrix if row[vocab_idx] > 0)
                idf = math.log(n_docs / (1 + doc_freq))

                query_vector[vocab_idx] = tf * idf

        return query_vector

    def _ngram_similarity_improved(self, text1: str, text2: str, n: int = 4) -> float:
        def preprocess_text(text: str) -> str:
            text = ' '.join(text.split()).lower()
            text = re.sub(r'\b\w*\d\w*\b', 'VAR', text) 
            return text

        def get_ngrams(text: str, n: int) -> Counter:
            text = preprocess_text(text)
            if len(text) < n:
                return Counter([text])
            ngrams = [text[i:i + n] for i in range(len(text) - n + 1)]
            return Counter(ngrams)

        ngrams1 = get_ngrams(text1, n)
        ngrams2 = get_ngrams(text2, n)

        if not ngrams1 or not ngrams2:
            return 0.0
        intersection = sum((ngrams1 & ngrams2).values())
        total = sum(ngrams1.values()) + sum(ngrams2.values())

        return 2 * intersection / total if total > 0 else 0.0

    def get_statistics(self) -> Dict:
        if len(self.cases_df) == 0:
            return {"total_cases": 0}

        error_type_dist = self.cases_df['error_type'].value_counts().to_dict()

        return {
            "total_cases": len(self.cases_df),
            "vocabulary_size": self.vocab_size if hasattr(self, 'vocab_size') else 0,
            "error_type_distribution": error_type_dist,
            "avg_key_terms": self.cases_df['key_terms'].apply(len).mean(),
            "similarity_threshold": self.similarity_threshold
        }
