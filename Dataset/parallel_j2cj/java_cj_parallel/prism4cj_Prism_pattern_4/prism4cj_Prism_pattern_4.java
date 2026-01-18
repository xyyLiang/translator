    @NotNull
    public static Pattern pattern(
            @NotNull java.util.regex.Pattern regex,
            boolean lookbehind,
            boolean greedy,
            @Nullable String alias,
            @Nullable Grammar inside) {
        return new PatternImpl(regex, lookbehind, greedy, alias, inside);
    }
