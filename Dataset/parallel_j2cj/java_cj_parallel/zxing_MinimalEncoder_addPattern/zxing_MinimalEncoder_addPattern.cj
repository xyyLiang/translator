    static func addPattern(
        patterns: ArrayList<Array<Int64>>,
        patternIndex: Int64,
        checkSum: Array<Int64>,
        checkWeight: Array<Int64>,
        position: Int64
    ) {
        patterns.append(Code128Reader.CODE_PATTERNS[patternIndex])
        if (position != 0) {
            checkWeight[0] += 1
        }
        checkSum[0] += patternIndex * checkWeight[0]
    }