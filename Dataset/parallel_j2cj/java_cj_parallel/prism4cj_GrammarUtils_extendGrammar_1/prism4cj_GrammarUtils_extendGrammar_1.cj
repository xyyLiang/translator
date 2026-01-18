    public static func extendGrammar(grammar: Grammar, name: String, filter: TokenFilter, tokens: ?ArrayList<Token>): Grammar {
        let size: Int64 = if (let Some(v) <- tokens) {
            v.size
        } else {
            0
        }
        var overrides: HashMap<String, Token>
        if (size == 0) {
            overrides = HashMap<String, Token>()
        } else {
            overrides = HashMap<String, Token>(size)
            if (let Some(v) <- tokens) {
                for (i in 0..v.size) {
                    overrides.put(v[i].name(), v[i])
                }
            }
        }
        let origins: ArrayList<Token> = grammar.tokens()
        var out: ArrayList<Token> = ArrayList<Token>(origins.size)
        var override: ?Token
        for (i in 0..origins.size) {
            // filter out undesired tokens
            if (!filter.test(origins[i])) {
                continue
            }
            override = overrides.get(origins[i].name())
            if (let Some(v) <- override) {
                out.append(v)
            } else {
                out.append(clone(origins[i]))
            }
        }
        return GrammarImpl(name, out)
    }
