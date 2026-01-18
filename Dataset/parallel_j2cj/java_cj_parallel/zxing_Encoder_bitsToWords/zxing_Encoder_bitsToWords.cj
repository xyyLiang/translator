    static func bitsToWords(stuffedBits: BitArray, wordSize: Int64, totalWords: Int64): Array<Int64> {
        let message = Array<Int64>(totalWords, item: 0)
        var i = 0
        var n = stuffedBits.size / wordSize
        while (i < n) {
            var value = 0
            for (j in 0..wordSize) {
                value |= if (stuffedBits.get(i * wordSize + j)) {
                    (1 << wordSize - j - 1)
                } else {
                    0
                }
            }
            message[i] = value
        }
        message
    }