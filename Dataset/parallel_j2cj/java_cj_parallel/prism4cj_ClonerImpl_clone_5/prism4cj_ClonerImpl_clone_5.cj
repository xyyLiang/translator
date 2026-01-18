    func clone(context: Context, pattern: Pattern): Pattern {
        var contextPattern: ?Pattern = context.pattern(pattern)
        if (let Some(v) <- contextPattern) {
            return v
        }
        var inside: ?Grammar = pattern.inside()
        if (let Some(v) <- inside) {
            contextPattern = PatternImpl(pattern.regex(), pattern.lookbehind(), pattern.greedy(), pattern.alias(),
                clone(context, v))
        } else {
            contextPattern = PatternImpl(pattern.regex(), pattern.lookbehind(), pattern.greedy(), pattern.alias(), None)
        }
        context.save(MyHashKey<Pattern>(pattern), contextPattern)
        return contextPattern.getOrThrow()
    }