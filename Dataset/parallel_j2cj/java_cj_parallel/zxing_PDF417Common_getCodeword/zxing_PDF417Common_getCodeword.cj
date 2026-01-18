    static func getCodeword(symbol: Int64): Int64 {
        var low = 0
        var high = SYMBOL_TABLE.size - 1

        var index = -1
        let key = symbol & 0x3FFFF
        while (low <= high) {
            let mid = (low + high) >> 1
            let midVal = SYMBOL_TABLE[mid]

            if (midVal < key) {
                low = mid + 1
            } else if (midVal > key) {
                high = mid - 1
            } else {
                index = mid
                break
            }
        }
        if (index == -1) {
            index = -(low + 1)
        }
        if (index < 0) {
            -1
        } else {
            (CODEWORD_TABLE[index] - 1) % NUMBER_OF_CODEWORDS
        }
    }