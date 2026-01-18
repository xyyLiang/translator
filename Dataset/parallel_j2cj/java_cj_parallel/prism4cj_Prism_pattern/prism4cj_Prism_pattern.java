    @NotNull
    public static Pattern pattern(@NotNull java.util.regex.Pattern regex) {
        return new PatternImpl(regex, false, false, null, null);
    }