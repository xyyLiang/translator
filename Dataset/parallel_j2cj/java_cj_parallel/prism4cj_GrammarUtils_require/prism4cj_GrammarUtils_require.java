    @NotNull
    public static Prism4j.Grammar require(@NotNull Prism4j prism4j, @NotNull String name) {
        final Prism4j.Grammar grammar = prism4j.grammar(name);
        if (grammar == null) {
            throw new IllegalStateException("Unexpected state, requested language is not found: " + name);
        }
        return grammar;
    }