    static func stuffBits(bits: BitArray, wordSize: Int64): BitArray {
        let out = BitArray()

        let n = bits.size
        let mask = (1 << wordSize) - 2
        var i = 0
        while (i < n) {
            var word = 0
            for (j in 0..wordSize) {
                if (i + j >= n || bits.get(i + j)) {
                    word |= 1 << (wordSize - 1 - j)
                }
            }
            if ((word & mask) == mask) {
                out.appendBits(word & mask, wordSize)
                i--
            } else if ((word & mask) == 0) {
                out.appendBits(word | 1, wordSize)
                i--
            } else {
                out.appendBits(word, wordSize)
            }
            i += wordSize
        }
        return out
    }