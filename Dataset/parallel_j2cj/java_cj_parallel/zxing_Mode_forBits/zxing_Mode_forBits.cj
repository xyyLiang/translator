    public static func forBits(bits: Int64): Mode {
        match (bits) {
            case 0x0 => TERMINATOR

            case 0x1 => NUMERIC

            case 0x2 => ALPHANUMERIC

            case 0x3 => STRUCTURED_APPEND

            case 0x4 => BYTE

            case 0x5 => FNC1_FIRST_POSITION

            case 0x7 => ECI

            case 0x8 => KANJI

            case 0x9 => FNC1_SECOND_POSITION

            case 0xD => HANZI

            case _ => throw IllegalArgumentException()
        }
    }
