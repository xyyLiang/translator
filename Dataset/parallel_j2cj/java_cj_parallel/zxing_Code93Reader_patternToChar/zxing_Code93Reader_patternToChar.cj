    static func patternToChar(pattern: Int64): Char {
        for (i in 0..CHARACTER_ENCODINGS.size) {
            if (CHARACTER_ENCODINGS[i] == pattern) {
                return ALPHABET[i]
            }
        }
        throw NotFoundException()
    }