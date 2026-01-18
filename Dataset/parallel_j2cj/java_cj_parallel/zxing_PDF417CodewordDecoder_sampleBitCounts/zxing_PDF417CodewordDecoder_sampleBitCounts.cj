    static func sampleBitCounts(moduleBitCount: Array<Int64>): Array<Int64> {
        let bitCountSum = util.sum(moduleBitCount)
        let result = Array<Int64>(PDF417Common.BARS_IN_MODULE, item: 0)
        var bitCountIndex = 0
        var sumPreviousBits = 0
        for (i in 0..PDF417Common.MODULES_IN_CODEWORD) {
            let sampleIndex = bitCountSum / (2 * PDF417Common.MODULES_IN_CODEWORD) + (i * bitCountSum) / PDF417Common.
            MODULES_IN_CODEWORD
            if (sumPreviousBits + moduleBitCount[bitCountIndex] <= sampleIndex) {
                sumPreviousBits += moduleBitCount[bitCountIndex]
                bitCountIndex++
            }
            result[bitCountIndex] += 1
        }
        result
    }