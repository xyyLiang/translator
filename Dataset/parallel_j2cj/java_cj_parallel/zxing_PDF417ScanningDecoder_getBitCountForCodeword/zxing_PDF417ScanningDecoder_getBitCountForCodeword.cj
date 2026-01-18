    static func getBitCountForCodeword(ocodeword: Int64): Array<Int64> {
        var codeword = ocodeword
        let result = Array<Int64>(8, item: 0)
        var previousValue = 0
        var i = result.size - 1
        while (true) {
            if ((codeword & 0x1) != previousValue) {
                previousValue = codeword & 0x1
                i--
                if (i < 0) {
                    break
                }
            }
            result[i] += 1
            codeword >>= 1
        }
        result
    }