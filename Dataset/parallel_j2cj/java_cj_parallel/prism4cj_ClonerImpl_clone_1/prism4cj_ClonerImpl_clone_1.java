        @NotNull
        @Override
        Prism4j.Token clone(@NotNull Prism4j.Token token) {
            return clone(new ContextImpl(), token);
        }