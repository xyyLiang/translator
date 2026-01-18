    static func determineCheckDigit(lgPatternFound: Int64): Int64 {
        for (d in 0..10) {
            if (lgPatternFound == CHECK_DIGIT_ENCODINGS[d]) {
                return d
            }
        }
        throw NotFoundException()
    }