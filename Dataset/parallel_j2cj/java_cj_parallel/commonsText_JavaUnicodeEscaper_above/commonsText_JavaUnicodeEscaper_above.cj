    public static func above(codePoint: Char): JavaUnicodeEscaper {
        return outsideOf(CHAR_MIN, codePoint);
    }