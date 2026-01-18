    public static func outsideOf(codePointLow: Char, codePointHigh: Char): NumericEntityEscaper {
        return NumericEntityEscaper(codePointLow, codePointHigh, false);
    }