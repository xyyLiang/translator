from tree_sitter import Language, Parser
import tree_sitter_java  
import os

JAVA_LANGUAGE = Language(tree_sitter_java.language())
parser = Parser(JAVA_LANGUAGE)

CONTROL_FLOW_TYPES = {
    "if_statement": "if",
    "for_statement": "for",
    "enhanced_for_statement": "for-each",
    "while_statement": "while",
    "do_statement": "do-while",
    "switch_statement": "switch",
    "try_statement": "try-catch"
}
def get_node_text(code_bytes, node):
    return code_bytes[node.start_byte:node.end_byte].decode("utf-8")

def extract_method_info(java_code):
    if isinstance(java_code, bytes):
        code_bytes = java_code
    else:
        code_bytes = java_code.encode("utf-8")

    tree = parser.parse(code_bytes)
    root = tree.root_node

    def find_first_method(node):
        if node.type == "method_declaration":
            return node
        for child in node.children:
            result = find_first_method(child)
            if result:
                return result
        return None

    method_node = find_first_method(root)

    if not method_node:
        print("No method found.")
        return

    output = ["[Method]"]

    return_type_node = method_node.child_by_field_name("type")
    return_type = get_node_text(code_bytes, return_type_node) if return_type_node else "void"

    func_name = method_node.child_by_field_name("name")
    output.append(f"function name: {get_node_text(code_bytes, func_name)}")

    params = method_node.child_by_field_name("parameters")
    param_str = get_node_text(code_bytes, params).strip("()")
    output.append(f"parameters: ({param_str})")

    body = method_node.child_by_field_name("body")
    local_vars = []
    control_flows = []
    method_calls = []
    return_values = []

    def visit(node):
        if node.type == "local_variable_declaration":
            var_type = get_node_text(code_bytes, node.child_by_field_name("type"))
            declarators = node.children_by_field_name("declarator")
            for decl in declarators:
                name = get_node_text(code_bytes, decl.child_by_field_name("name"))
                local_vars.append(f"{var_type} {name}")
        elif node.type == "method_invocation":
            method_calls.append(get_node_text(code_bytes, node))
        elif node.type == "return_statement":
            value_node = None
            for child in node.children:
                if child.type not in ["return", ";"]:
                    value_node = child
                    break
            if value_node:
                return_val = get_node_text(code_bytes, value_node)
                return_values.append(f"{return_type} {return_val}")
            else:
                return_values.append("void")
        elif node.type in CONTROL_FLOW_TYPES:
            label = CONTROL_FLOW_TYPES[node.type]
            if node.type == "if_statement":
                alt = node.child_by_field_name("alternative")
                if alt: label = "if-else"
            snippet = get_node_text(code_bytes, node).replace("\n", " ").strip()
            control_flows.append(f"- {label}: {snippet}")

        for child in node.children:
            visit(child)
    visit(body)

    if local_vars:
        output.append(f"local variable declaration: {', '.join(local_vars)}")
    if control_flows:
        output.append("control flow:")
        output.extend([f"  {cf}" for cf in control_flows])
    if method_calls:
        output.append(f"method invocation: {', '.join(method_calls)}")
    if return_values:
        output.append(f"return: {', '.join(return_values)}")
    return "\n".join(output)

