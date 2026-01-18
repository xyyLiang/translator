    public static func extendGrammar(grammar: Grammar, name: String, tokens: ?ArrayList<Token>): Grammar {
        // we clone the whole grammar, but override top-most tokens that are passed here
        let size: Int64 = if (let Some(v) <- tokens) {
            v.size
        } else {
            0
        }
        if (size == 0) {
            return GrammarImpl(name, clone(grammar).tokens())
        }
        let overrides: HashMap<String, Token> = HashMap<String, Token>(size)
        if (let Some(v) <- tokens) {
            for (i in 0..v.size) {
                overrides.put(v[i].name(), v[i])
            }
        }
        let origins: ArrayList<Token> = grammar.tokens()
        var out: ArrayList<Token> = ArrayList<Token>(origins.size)
        var override: ?Token
        for (i in 0..origins.size) {
            override = overrides.get(origins[i].name())
            if (let Some(v) <- override) {
                out.append(v)
            } else {
                out.append(clone(origins[i]))
            }
        }
        return GrammarImpl(name, out)
    }
