    static func getDecodedCodewordValue(moduleBitCount: Array<Int64>): Int64 {
        let decodedValue = getBitValue(moduleBitCount)
        if (PDF417Common.getCodeword(decodedValue) == -1) {
            -1
        } else {
            decodedValue
        }
    }