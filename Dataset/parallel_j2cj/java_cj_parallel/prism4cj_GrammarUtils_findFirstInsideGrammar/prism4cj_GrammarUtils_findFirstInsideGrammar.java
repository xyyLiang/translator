    @Nullable
    public static Prism4j.Grammar findFirstInsideGrammar(@NotNull Prism4j.Token token) {
        Prism4j.Grammar grammar = null;
        for (Prism4j.Pattern pattern : token.patterns()) {
            if (pattern.inside() != null) {
                grammar = pattern.inside();
                break;
            }
        }
        return grammar;
    }