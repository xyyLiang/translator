    @NotNull
    static String toString(@NotNull Prism4j.Pattern pattern) {
        final StringBuilder builder = new StringBuilder();
        toString(builder, new CacheImpl(), pattern);
        return builder.toString();
    }