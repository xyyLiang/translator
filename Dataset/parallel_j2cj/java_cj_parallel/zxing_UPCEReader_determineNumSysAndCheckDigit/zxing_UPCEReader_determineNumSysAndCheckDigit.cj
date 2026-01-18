    static func determineNumSysAndCheckDigit(resultString: StringBuilder, lgPatternFound: Int64) {
        for (numSys in 0..2) {
            for (d in 0..10) {
                if (lgPatternFound == NUMSYS_AND_CHECK_DIGIT_PATTERNS[numSys][d]) {
                    resultString.insert(0, Char(UInt32('0') + UInt32(numSys)))
                    resultString.append(Char(UInt32('0') + UInt32(d)))
                    return
                }
            }
        }
        throw NotFoundException()
    }