    static func encodeChar(c: Char, sb: StringBuilder) {
        if (c >= ' ' && c <= '?') {
            sb.append(c)
        } else if (c >= '@' && c <= '^') {
            sb.append(Char(UInt32(c) - 64))
        } else {
            HighLevelEncoder.illegalCharacter(c)
        }
    }