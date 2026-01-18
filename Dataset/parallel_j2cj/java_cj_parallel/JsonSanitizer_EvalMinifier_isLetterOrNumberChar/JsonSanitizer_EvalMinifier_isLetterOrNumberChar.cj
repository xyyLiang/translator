    private static func isLetterOrNumberChar(ch: Char): Bool {
        if ('0' <= ch && ch <= '9') {
            return true
        }
        let lch = ch.toAsciiLowerCase()
        if ('a' <= lch && lch <= 'z') {
            return true
        }
        return ch == '_' || ch == '$' || ch == '-' || ch == '.'
    }