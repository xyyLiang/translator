    public static void insertBeforeToken(
            @NotNull Prism4j.Grammar grammar,
            @NotNull String path,
            Prism4j.Token... tokens
    ) {

        if (tokens == null
                || tokens.length == 0) {
            return;
        }

        final String[] parts = path.split("/");

        insertBeforeToken(grammar, parts, 0, tokens);
    }
