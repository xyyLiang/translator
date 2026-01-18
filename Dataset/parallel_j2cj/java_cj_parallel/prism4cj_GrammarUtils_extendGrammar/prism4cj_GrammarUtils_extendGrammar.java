    @NotNull
    public static Prism4j.Grammar extend(
            @NotNull Prism4j.Grammar grammar,
            @NotNull String name,
            Prism4j.Token... tokens) {

        // we clone the whole grammar, but override top-most tokens that are passed here

        final int size = tokens != null
                ? tokens.length
                : 0;

        if (size == 0) {
            return new GrammarImpl(name, clone(grammar).tokens());
        }

        final Map<String, Prism4j.Token> overrides = new HashMap<>(size);
        for (Prism4j.Token token : tokens) {
            overrides.put(token.name(), token);
        }

        final List<Prism4j.Token> origins = grammar.tokens();
        final List<Prism4j.Token> out = new ArrayList<>(origins.size());

        Prism4j.Token override;

        for (Prism4j.Token origin : origins) {
            override = overrides.get(origin.name());
            if (override != null) {
                out.add(override);
            } else {
                out.add(clone(origin));
            }
        }

        return new GrammarImpl(name, out);
    }
