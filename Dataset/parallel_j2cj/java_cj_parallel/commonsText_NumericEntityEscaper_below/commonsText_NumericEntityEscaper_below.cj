    public static func below(codePoint: Char): NumericEntityEscaper {
        return outsideOf(codePoint, Char(0x10FFFF));
    }