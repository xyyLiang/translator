    static func determineFirstDigit(resultString: StringBuilder, lgPatternFound: Int64) {
        for (d in 0..10) {
            if (lgPatternFound == FIRST_DIGIT_ENCODINGS[d]) {
                resultString.insert(0, Char(UInt32('0') + UInt32(d)))
                return
            }
        }
        throw NotFoundException()
    }