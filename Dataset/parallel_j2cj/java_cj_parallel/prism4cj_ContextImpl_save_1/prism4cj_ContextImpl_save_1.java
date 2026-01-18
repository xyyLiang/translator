            @Override
            public void save(@NotNull Prism4j.Token origin, @NotNull Prism4j.Token clone) {
                cache.put(key(origin), clone);
            }