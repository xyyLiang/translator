    private static void toString(@NotNull StringBuilder builder, @NotNull Cache cache, @NotNull Prism4j.Pattern pattern) {

        builder
                .append("Pattern{id=0x")
                .append(Integer.toHexString(System.identityHashCode(pattern)));

        if (cache.visited(pattern)) {
            builder.append(",[...]");
        } else {

            cache.markVisited(pattern);

            builder.append(",regex=\"").append(pattern.regex()).append('\"');

            if (pattern.lookbehind()) {
                builder.append(",lookbehind=true");
            }

            if (pattern.greedy()) {
                builder.append(",greedy=true");
            }

            if (pattern.alias() != null) {
                builder.append(",alias=\"").append(pattern.alias()).append('\"');
            }

            final Prism4j.Grammar inside = pattern.inside();
            if (inside != null) {
                builder.append(",inside=");
                toString(builder, cache, inside);
            }
        }

        builder.append('}');
    }
