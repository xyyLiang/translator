    public static func findFirstInsideGrammar(token: Token): ?Grammar {
        var grammar: ?Grammar = None
        for (i in 0..token.patterns().size) {
            if (let Some(v) <- token.patterns()[i].inside()) {
                grammar = v
                break
            }
        }
        return grammar
    }
