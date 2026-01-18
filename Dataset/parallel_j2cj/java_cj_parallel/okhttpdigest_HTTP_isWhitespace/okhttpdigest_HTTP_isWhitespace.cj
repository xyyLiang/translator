    public static func isWhitespace(ch: Char): Bool {
        return UInt32(ch) == 32 || UInt32(ch) == 9 || UInt32(ch) == 13 || UInt32(ch) == 10
    }