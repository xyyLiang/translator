        @NotNull
        private Prism4j.Pattern clone(@NotNull Context context, @NotNull Prism4j.Pattern pattern) {

            Prism4j.Pattern clone = context.pattern(pattern);
            if (clone != null) {
                return clone;
            }

            final Prism4j.Grammar inside = pattern.inside();

            clone = new PatternImpl(
                    pattern.regex(),
                    pattern.lookbehind(),
                    pattern.greedy(),
                    pattern.alias(),
                    inside != null ? clone(context, inside) : null
            );

            context.save(pattern, clone);

            return clone;
        }