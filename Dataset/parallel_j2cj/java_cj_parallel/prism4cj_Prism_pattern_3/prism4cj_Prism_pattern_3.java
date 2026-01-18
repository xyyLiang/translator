    @NotNull
    public static Pattern pattern(
            @NotNull java.util.regex.Pattern regex,
            boolean lookbehind,
            boolean greedy,
            @Nullable String alias) {
        return new PatternImpl(regex, lookbehind, greedy, alias, null);
    }