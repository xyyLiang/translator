    static func readCode(rawbits: Array<Bool>, startIndex: Int64, length: Int64): Int64 {
        var res = 0
        for (i in startIndex..(startIndex + length)) {
            res <<= 1
            if (rawbits[i]) {
                res |= 0x01
            }
        }
        res
    }