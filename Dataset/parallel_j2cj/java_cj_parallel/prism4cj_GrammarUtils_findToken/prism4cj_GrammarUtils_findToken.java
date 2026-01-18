    @Nullable
    public static Prism4j.Token findToken(@NotNull Prism4j.Grammar grammar, @NotNull String path) {
        final String[] parts = path.split("/");
        return findToken(grammar, parts, 0);
    }