    public static NumericEntityEscaper between(final int codePointLow, final int codePointHigh) {
        return new NumericEntityEscaper(codePointLow, codePointHigh, true);
    }