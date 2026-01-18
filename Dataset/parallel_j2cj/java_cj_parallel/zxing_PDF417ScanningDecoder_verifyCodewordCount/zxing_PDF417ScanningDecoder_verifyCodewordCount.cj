    static func verifyCodewordCount(codewords: Array<Int64>, numECCodewords: Int64) {
        if (codewords.size < 4) {
            throw FormatException()
        }

        let numberOfCodewords = codewords[0]
        if (numberOfCodewords > codewords.size) {
            throw FormatException()
        }
        if (numberOfCodewords == 0) {
            if (numECCodewords < codewords.size) {
                codewords[0] = codewords.size - numECCodewords
            } else {
                throw FormatException()
            }
        }
    }