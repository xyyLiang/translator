    @Nullable
    public Grammar grammar(@NotNull String name) {
        return grammarLocator.grammar(this, name);
    }