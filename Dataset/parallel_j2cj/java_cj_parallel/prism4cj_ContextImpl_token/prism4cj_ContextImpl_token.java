            @Nullable
            @Override
            public Prism4j.Token token(@NotNull Prism4j.Token origin) {
                return (Prism4j.Token) cache.get(key(origin));
            }