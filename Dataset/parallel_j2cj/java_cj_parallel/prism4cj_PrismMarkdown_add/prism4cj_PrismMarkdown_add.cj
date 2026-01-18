    private static func add(grammar: ?Grammar, first: Token, second: Token): Unit {
        if (let Some(v) <- grammar) {
            v.tokens().append(first)
            v.tokens().append(second)
        }
    }