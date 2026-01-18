
    private static void toString(@NotNull StringBuilder builder, @NotNull Cache cache, @NotNull Prism4j.Grammar grammar) {

        builder
                .append("Grammar{id=0x")
                .append(Integer.toHexString(System.identityHashCode(grammar)))
                .append(",name=\"")
                .append(grammar.name())
                .append('\"');

        if (cache.visited(grammar)) {
            builder.append(",[...]");
        } else {
            cache.markVisited(grammar);
            builder.append(",tokens=[");
            boolean first = true;
            for (Prism4j.Token token : grammar.tokens()) {
                if (first) {
                    first = false;
                } else {
                    builder.append(',');
                }
                toString(builder, cache, token);
            }
            builder.append(']');
        }

        builder.append('}');
    }