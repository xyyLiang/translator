    static func correctErrors(codewords: Array<Int64>, erasures: Array<Int64>, numECCodewords: Int64): Int64 {
        if (erasures.size > numECCodewords / 2 + MAX_ERRORS || numECCodewords < 0 || numECCodewords > MAX_EC_CODEWORDS) {
            throw ChecksumException()
        } else {
            errorCorrection.decode(codewords, numECCodewords, erasures)
        }
    }