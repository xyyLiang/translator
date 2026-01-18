        @NotNull
        @Override
        Prism4j.Grammar clone(@NotNull Prism4j.Grammar grammar) {
            return clone(new ContextImpl(), grammar);
        }