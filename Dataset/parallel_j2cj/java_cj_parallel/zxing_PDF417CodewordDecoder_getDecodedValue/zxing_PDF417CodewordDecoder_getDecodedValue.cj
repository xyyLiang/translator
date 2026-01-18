    static func getDecodedValue(moduleBitCount: Array<Int64>): Int64 {
        let decodedValue = getDecodedCodewordValue(sampleBitCounts(moduleBitCount))
        if (decodedValue != -1) {
            decodedValue
        } else {
            getClosestDecodedValue(moduleBitCount)
        }
    }
