    func decodeIsoIec646(pos: Int64): DecodedChar {
        let fiveBitValue = extractNumericValueFromBitArray(pos, 5)
        if (fiveBitValue == 15) {
            return DecodedChar(pos + 5, DecodedChar.FNC1)
        }

        if (fiveBitValue >= 5 && fiveBitValue < 15) {
            return DecodedChar(pos + 5, Char(UInt32('0') + UInt32(fiveBitValue) - 5))
        }

        let sevenBitValue = extractNumericValueFromBitArray(pos, 7)

        if (sevenBitValue >= 64 && sevenBitValue < 90) {
            return DecodedChar(pos + 7, Char(UInt32(sevenBitValue) + 1))
        }

        if (sevenBitValue >= 90 && sevenBitValue < 116) {
            return DecodedChar(pos + 7, Char(UInt32(sevenBitValue) + 7))
        }

        let eightBitValue = extractNumericValueFromBitArray(pos, 8)
        let c = match (eightBitValue) {
            case 232 => '!'
            case 233 => '"'
            case 234 => '%'
            case 235 => '&'
            case 236 => '\''
            case 237 => '('
            case 238 => ')'
            case 239 => '*'
            case 240 => '+'
            case 241 => ','
            case 242 => '-'
            case 243 => '.'
            case 244 => '/'
            case 245 => ':'
            case 246 => ';'
            case 247 => '<'
            case 248 => '='
            case 249 => '>'
            case 250 => '?'
            case 251 => '_'
            case 252 => ' '
            case _ => throw FormatException()
        }
        return DecodedChar(pos + 8, c)
    }
