        @NotNull
        private Prism4j.Token clone(@NotNull Context context, @NotNull Prism4j.Token token) {

            Prism4j.Token clone = context.token(token);
            if (clone != null) {
                return clone;
            }

            final List<Prism4j.Pattern> patterns = token.patterns();
            final List<Prism4j.Pattern> out = new ArrayList<>(patterns.size());

            clone = new TokenImpl(token.name(), out);
            context.save(token, clone);

            for (Prism4j.Pattern pattern : patterns) {
                out.add(clone(context, pattern));
            }

            return clone;
        }