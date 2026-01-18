            @Nullable
            @Override
            public Prism4j.Pattern pattern(@NotNull Prism4j.Pattern origin) {
                return (Prism4j.Pattern) cache.get(key(origin));
            }