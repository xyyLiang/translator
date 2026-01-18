    public static NumericEntityEscaper outsideOf(final int codePointLow, final int codePointHigh) {
        return new NumericEntityEscaper(codePointLow, codePointHigh, false);
    }