    override func encodeChar(c: Char, sb: StringBuilder): Int64 {
        match (c) {
            case '\r' => sb.append('\u{0}')
            case '*' => sb.append('\u{1}')
            case '>' => sb.append('\u{2}')
            case ' ' => sb.append('\u{3}')
            case _ =>
                if (c >= '0' && c <= '9') {
                    sb.append(Char(UInt32(c) - 48 + 4))
                } else if (c >= 'A' && c <= 'Z') {
                    sb.append(Char(UInt32(c) - 65 + 14))
                } else {
                    HighLevelEncoder.illegalCharacter(c)
                }
        }
        1
    }