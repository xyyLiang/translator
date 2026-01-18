    public static NumericEntityEscaper below(final int codePoint) {
        return outsideOf(codePoint, Integer.MAX_VALUE);
    }