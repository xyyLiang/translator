    @NotNull
    static String toString(@NotNull Prism4j.Grammar grammar) {
        final StringBuilder builder = new StringBuilder();
        toString(builder, new CacheImpl(), grammar);
        return builder.toString();
    }