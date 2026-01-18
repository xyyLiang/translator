    public static func outsideOf(codePointLow: Char, codePointHigh: Char): JavaUnicodeEscaper {
        return JavaUnicodeEscaper(codePointLow, codePointHigh, false);
    }