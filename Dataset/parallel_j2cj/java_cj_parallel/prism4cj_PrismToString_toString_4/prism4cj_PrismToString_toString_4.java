    private static void toString(@NotNull StringBuilder builder, @NotNull Cache cache, @NotNull Prism4j.Token token) {

        builder
                .append("Token{id=0x")
                .append(Integer.toHexString(System.identityHashCode(token)))
                .append(",name=\"")
                .append(token.name())
                .append('\"');

        if (cache.visited(token)) {
            builder.append(",[...]");
        } else {
            cache.markVisited(token);
            builder.append(",patterns=[");
            boolean first = true;
            for (Prism4j.Pattern pattern : token.patterns()) {
                if (first) {
                    first = false;
                } else {
                    builder.append(',');
                }
                toString(builder, cache, pattern);
            }
            builder.append(']');
        }
        builder.append('}');
    }