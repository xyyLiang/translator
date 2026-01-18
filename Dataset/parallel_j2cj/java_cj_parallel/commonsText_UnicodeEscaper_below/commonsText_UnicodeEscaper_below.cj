    public static func below(codePoint: Char): UnicodeEscaper {
        return outsideOf(codePoint, CHAR_MAX);
    }