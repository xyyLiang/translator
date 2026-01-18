            @Nullable
            @Override
            public Prism4j.Grammar grammar(@NotNull Prism4j.Grammar origin) {
                return (Prism4j.Grammar) cache.get(key(origin));
            }