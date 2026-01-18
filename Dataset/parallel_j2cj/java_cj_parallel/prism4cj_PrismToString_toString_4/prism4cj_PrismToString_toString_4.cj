    private static func toString(builder: StringBuilder, cache: Cache, token: Token) {
        builder.append("Token{id=0x")
        builder.append(token.hashCode())
        builder.append(",name=\"")
        builder.append(token.name())
        builder.append('\"')

        if (cache.visitedToken(token)) {
            builder.append(",[...]")
        } else {
            cache.markVisitedToken(token)
            builder.append(",patterns=[")
            var first: Bool = true
            for (i in 0..token.patterns().size) {
                if (first) {
                    first = false
                } else {
                    builder.append(',')
                }
                toString(builder, cache, token.patterns()[i])
            }
            builder.append(']')
        }
        builder.append('}')
    }