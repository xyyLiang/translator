    private static void insertTokensAt(
            int start,
            @NotNull List<Prism4j.Token> grammarTokens,
            @NotNull Prism4j.Token[] tokens
    ) {
        for (int i = 0, length = tokens.length; i < length; i++) {
            grammarTokens.add(start + i, tokens[i]);
        }
    }