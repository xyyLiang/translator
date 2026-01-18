    func clone(context: Context, token: Token): Token {
        var contextToken: ?Token = context.token(token)
        if (let Some(v) <- contextToken) {
            return v
        }
        var patterns: ArrayList<Pattern> = token.patterns()
        var out: ArrayList<Pattern> = ArrayList<Pattern>(patterns.size)
        contextToken = TokenImpl(token.name(), out)
        context.save(MyHashKey<Token>(token), contextToken)
        for (i in 0..patterns.size) {
            out.append(clone(context, patterns[i]))
        }
        return contextToken.getOrThrow()
    }