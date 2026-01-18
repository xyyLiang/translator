    public static func between(codePointLow: Char, codePointHigh: Char): JavaUnicodeEscaper {
        return JavaUnicodeEscaper(codePointLow, codePointHigh, true);
    }