    public static func between(codePointLow: Char, codePointHigh: Char): NumericEntityEscaper {
        return NumericEntityEscaper(codePointLow, codePointHigh, true);
    }