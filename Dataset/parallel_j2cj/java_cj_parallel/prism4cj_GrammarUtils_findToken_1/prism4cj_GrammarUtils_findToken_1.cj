    private static func findToken(grammar: Grammar, parts: Array<String>, index: Int64): ?Token {
        let part: String = parts[index]
        let last: Bool = index == parts.size - 1
        for (token in grammar.tokens()) {
            if (part == token.name()) {
                if (last) {
                    return token
                } else {
                    let inside: ?Grammar = findFirstInsideGrammar(token)
                    if (let Some(v) <- inside) {
                        return findToken(v, parts, index + 1)
                    } else {
                        break
                    }
                }
            }
        }
        return None
    }