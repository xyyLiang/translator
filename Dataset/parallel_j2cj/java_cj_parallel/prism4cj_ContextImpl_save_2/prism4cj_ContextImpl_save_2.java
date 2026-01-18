            @Override
            public void save(@NotNull Prism4j.Pattern origin, @NotNull Prism4j.Pattern clone) {
                cache.put(key(origin), clone);
            }