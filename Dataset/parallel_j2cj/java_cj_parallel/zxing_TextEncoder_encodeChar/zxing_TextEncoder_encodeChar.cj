    override func encodeChar(c: Char, sb: StringBuilder): Int64 {
        if (c == ' ') {
            sb.append('\u{3}')
            return 1
        }
        if (c >= '0' && c <= '9') {
            sb.append(Char(UInt32(c) - 48 + 4))
            return 1
        }
        if (c >= 'a' && c <= 'z') {
            sb.append(Char(UInt32(c) - 97 + 14))
            return 1
        }
        if (c < ' ') {
            sb.append('\u{0}')
            sb.append(c)
            return 2
        }
        if (c <= '/') {
            sb.append('\u{1}')
            sb.append(Char(UInt32(c) - 33))
            return 2
        }
        if (c <= '@') {
            sb.append('\u{1}')
            sb.append(Char(UInt32(c) - 58 + 15))
            return 2
        }
        if (c >= '[' && c <= '_') {
            sb.append('\u{1}')
            sb.append(Char(UInt32(c) - 91 + 22))
            return 2
        }
        if (c == '`') {
            sb.append('\u{2}')
            sb.append(Char(0))
            return 2
        }
        if (c <= 'Z') {
            sb.append('\u{2}')
            sb.append(Char(UInt32(c) - 65 + 1))
            return 2
        }
        if (c <= Char(127)) {
            sb.append('\u{2}')
            sb.append(Char(UInt32(c) - 123 + 27))
            return 2
        }
        sb.append("\u{1}\u{001e}")
        encodeChar(Char(UInt32(c) - 128), sb) + 2
    }