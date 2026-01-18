    static func decodeExtended(encoded: String): String {
        let length = encoded.size
        let decoded = StringBuilder()
        var i = 0
        while (i < length) {
            let c = encoded.charAt(i)
            if (c >= 'a' && c <= 'd') {
                if (i >= length - 1) {
                    throw FormatException()
                }
                let next = encoded.charAt(i + 1)
                var decodedChar = match (c) {
                    case 'd' =>
                        if (next >= 'A' && next <= 'Z') {
                            Char(UInt32(next) + 32)
                        } else {
                            throw FormatException()
                        }
                    case 'a' =>
                        if (next >= 'A' && next <= 'Z') {
                            Char(UInt32(next) - 64)
                        } else {
                            throw FormatException()
                        }
                    case 'b' =>
                        if (next >= 'A' && next <= 'E') {
                            Char(UInt32(next) - 38)
                        } else if (next >= 'F' && next <= 'J') {
                            Char(UInt32(next) - 11)
                        } else if (next >= 'K' && next <= 'O') {
                            Char(UInt32(next) + 16)
                        } else if (next >= 'P' && next <= 'T') {
                            Char(UInt32(next) + 43)
                        } else if (next == 'U') {
                            '\0'
                        } else if (next == 'V') {
                            '@'
                        } else if (next == 'W') {
                            '`'
                        } else if (next >= 'X' && next <= 'Z') {
                            Char(127)
                        } else {
                            throw FormatException()
                        }
                    case 'c' =>
                        if (next >= 'A' && next <= 'O') {
                            Char(UInt32(next) - 32)
                        } else if (next == 'Z') {
                            ':'
                        } else {
                            throw FormatException()
                        }
                    case _ => '\0'
                }
                decoded.append(decodedChar)
                i++
            } else {
                decoded.append(c)
            }
            i++
        }
        return decoded.toString()
    }