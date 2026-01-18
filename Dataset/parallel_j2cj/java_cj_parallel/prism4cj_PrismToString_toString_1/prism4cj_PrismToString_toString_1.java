    @NotNull
    static String toString(@NotNull Prism4j.Token token) {
        final StringBuilder builder = new StringBuilder();
        toString(builder, new CacheImpl(), token);
        return builder.toString();
    }