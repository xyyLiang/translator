    private static func isHex(ch: Char): Bool {
        if ('0' <= ch && ch <= '9') {
            return true
        }
        let lch = ch.toAsciiLowerCase()
        return 'a' <= lch && lch <= 'f'
    }