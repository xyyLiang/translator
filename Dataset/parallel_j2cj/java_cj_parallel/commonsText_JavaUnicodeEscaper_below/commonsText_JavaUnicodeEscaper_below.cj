    public static func below(codePoint: Char): JavaUnicodeEscaper {
        return outsideOf(codePoint, CHAR_MAX);
    }