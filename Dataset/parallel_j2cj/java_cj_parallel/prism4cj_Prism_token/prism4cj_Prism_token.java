    @NotNull
    public static Token token(@NotNull String name, @NotNull List<Pattern> patterns) {
        return new TokenImpl(name, patterns);
    }