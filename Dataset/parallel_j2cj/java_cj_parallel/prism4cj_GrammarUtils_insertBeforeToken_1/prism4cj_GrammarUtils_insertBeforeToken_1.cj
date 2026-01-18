    private static func insertBeforeToken(grammar: Grammar, parts: Array<String>, index: Int64, tokens: Array<Token>): Unit {
        let part: String = parts[index]
        let last: Bool = index == parts.size - 1
        let grammarTokens: ArrayList<Token> = grammar.tokens()
        var token: Token
        for (i in 0..grammarTokens.size) {
            token = grammarTokens.get(i).getOrThrow()
            if (part == token.name()) {
                // here we must decide what to do next:
                //  - it can be out found one
                //  - or we need to go deeper (c)
                if (last) {
                    // here we go, it's our token
                    insertTokensAt(i, grammarTokens, tokens)
                } else {
                    // now we must find a grammar that is inside
                    // token can have multiple patterns
                    // but as they are not identified somehow (no name or anything)
                    // we will try to find first pattern with inside grammar
                    let inside: ?Grammar = findFirstInsideGrammar(token)
                    if (let Some(v) <- inside) {
                        insertBeforeToken(v, parts, index + 1, tokens)
                    }
                }
                // break after we have found token with specified name (most likely it won't repeat itself)
                break
            }
        }
    }