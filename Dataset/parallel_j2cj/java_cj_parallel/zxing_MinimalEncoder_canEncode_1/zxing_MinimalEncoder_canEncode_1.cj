    func canEncode(mode: Mode, c: Char): Bool {
        match (mode) {
            case KANJI => isDoubleByteKanji(c)
            case ALPHANUMERIC => isAlphanumeric(c)
            case NUMERIC => isNumeric(c)
            case BYTE => true
            case _ => false
        }
    }