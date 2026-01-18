    private static func toString(builder: StringBuilder, cache: Cache, grammar: Grammar): Unit {
        builder.append("Grammar{id=0x")
        builder.append(grammar.hashCode())
        builder.append(",name=\"")
        builder.append(grammar.name())
        builder.append('\"')
        if (cache.visitedGrammar(grammar)) {
            builder.append(",[...]")
        } else {
            cache.markVisitedGrammar(grammar)
            builder.append(",tokens=[")
            var first: Bool = true
            for (i in 0..grammar.tokens().size) {
                if (first) {
                    first = false
                } else {
                    builder.append(',')
                }
                toString(builder, cache, grammar.tokens()[i])
            }
            builder.append(']')
        }
        builder.append('}')
    }