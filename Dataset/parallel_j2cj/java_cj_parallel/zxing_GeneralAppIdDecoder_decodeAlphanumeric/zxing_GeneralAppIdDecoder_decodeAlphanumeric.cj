    func decodeAlphanumeric(pos: Int64): DecodedChar {
        let fiveBitValue = extractNumericValueFromBitArray(pos, 5)
        if (fiveBitValue == 15) {
            return DecodedChar(pos + 5, DecodedChar.FNC1)
        }

        if (fiveBitValue >= 5 && fiveBitValue < 15) {
            return DecodedChar(pos + 5, Char(UInt32('0') + UInt32(fiveBitValue) - 5))
        }

        let sixBitValue = extractNumericValueFromBitArray(pos, 6)

        if (sixBitValue >= 32 && sixBitValue < 58) {
            return DecodedChar(pos + 6, Char(UInt32(sixBitValue) + 33))
        }

        let c = match (sixBitValue) {
            case 58 => '*'
            case 59 => ','
            case 60 => '-'
            case 61 => '.'
            case 62 => '/'
            case _ => throw Exception("Decoding invalid alphanumeric value: ${sixBitValue}")
        }
        DecodedChar(pos + 6, c)
    }