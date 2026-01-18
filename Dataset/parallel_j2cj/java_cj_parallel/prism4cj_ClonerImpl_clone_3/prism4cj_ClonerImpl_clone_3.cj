    func clone(context: Context, grammar: Grammar): Grammar {
        var contextGrammar: ?Grammar = context.grammar(grammar)
        if (let Some(v) <- contextGrammar) {
            return v
        }
        let tokens: ArrayList<Token> = grammar.tokens()
        var out: ArrayList<Token> = ArrayList<Token>(tokens.size)
        contextGrammar = GrammarImpl(grammar.name(), out)
        context.save(MyHashKey<Grammar>(grammar), contextGrammar)
        for (i in 0..tokens.size) {
            out.append(clone(context, tokens[i]))
        }
        return contextGrammar.getOrThrow()
    }