    private static func toString(builder: StringBuilder, cache: Cache, pattern: Pattern) {
        builder.append("Pattern{id=0x")
        builder.append(pattern.hashCode())
        if (cache.visitedPattern(pattern)) {
            builder.append(",[...]")
        } else {
            cache.markVisitedPattern(pattern)
            builder.append(",regex=\"")
            builder.append(pattern.regex().string())
            builder.append('\"')
            if (pattern.lookbehind()) {
                builder.append(",lookbehind=true")
            }
            if (pattern.greedy()) {
                builder.append(",greedy=true")
            }
            if (pattern.alias().isSome()) {
                builder.append(",alias=\"")
                builder.append(pattern.alias())
                builder.append('\"')
            }
            let inside: ?Grammar = pattern.inside()
            if (let Some(v) <- inside) {
                builder.append(",inside=")
                toString(builder, cache, v)
            }
        }
        builder.append('}')
    }