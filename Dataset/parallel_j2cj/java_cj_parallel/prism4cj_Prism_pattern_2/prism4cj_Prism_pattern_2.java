    @NotNull
    public static Pattern pattern(
            @NotNull java.util.regex.Pattern regex,
            boolean lookbehind,
            boolean greedy) {
        return new PatternImpl(regex, lookbehind, greedy, null, null);
    }