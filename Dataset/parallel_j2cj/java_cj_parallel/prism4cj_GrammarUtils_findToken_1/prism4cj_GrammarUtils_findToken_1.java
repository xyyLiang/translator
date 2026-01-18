    @Nullable
    private static Prism4j.Token findToken(@NotNull Prism4j.Grammar grammar, @NotNull String[] parts, int index) {

        final String part = parts[index];
        final boolean last = index == parts.length - 1;

        for (Prism4j.Token token : grammar.tokens()) {
            if (part.equals(token.name())) {
                if (last) {
                    return token;
                } else {
                    final Prism4j.Grammar inside = findFirstInsideGrammar(token);
                    if (inside != null) {
                        return findToken(inside, parts, index + 1);
                    } else {
                        break;
                    }
                }
            }
        }

        return null;
    }