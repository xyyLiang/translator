        @NotNull
        @Override
        Prism4j.Pattern clone(@NotNull Prism4j.Pattern pattern) {
            return clone(new ContextImpl(), pattern);
        }