    static func getCharacter(table: Table, code: Int64): String {
        match (table) {
            case UPPER => return UPPER_TABLE[code]
            case LOWER => return LOWER_TABLE[code]
            case MIXED => return MIXED_TABLE[code]
            case PUNCT => return PUNCT_TABLE[code]
            case DIGIT => return DIGIT_TABLE[code]
            case _ => throw Exception("Bad table")
        }
    }