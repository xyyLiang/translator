            @Override
            public void save(@NotNull Prism4j.Grammar origin, @NotNull Prism4j.Grammar clone) {
                cache.put(key(origin), clone);
            }