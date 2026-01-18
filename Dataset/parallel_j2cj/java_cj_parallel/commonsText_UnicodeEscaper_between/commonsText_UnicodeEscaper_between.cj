    public static func between(codePointLow: Char, codePointHigh: Char): UnicodeEscaper {
        return UnicodeEscaper(codePointLow, codePointHigh, true);
    }