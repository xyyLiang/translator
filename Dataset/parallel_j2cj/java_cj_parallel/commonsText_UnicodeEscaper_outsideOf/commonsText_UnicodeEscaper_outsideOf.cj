    public static func outsideOf(codePointLow: Char, codePointHigh: Char): UnicodeEscaper {
        return UnicodeEscaper(codePointLow, codePointHigh, false);
    }