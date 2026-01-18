        @NotNull
        private Prism4j.Grammar clone(@NotNull Context context, @NotNull Prism4j.Grammar grammar) {

            Prism4j.Grammar clone = context.grammar(grammar);
            if (clone != null) {
                return clone;
            }

            final List<Prism4j.Token> tokens = grammar.tokens();
            final List<Prism4j.Token> out = new ArrayList<>(tokens.size());

            clone = new GrammarImpl(grammar.name(), out);
            context.save(grammar, clone);

            for (Prism4j.Token token : tokens) {
                out.add(clone(context, token));
            }

            return clone;
        }