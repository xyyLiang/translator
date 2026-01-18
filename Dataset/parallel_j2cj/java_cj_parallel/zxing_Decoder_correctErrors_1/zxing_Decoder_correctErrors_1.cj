    func correctErrors(codewordBytes: Array<UInt8>, numDataCodewords: Int64) {
        let codewordsInts = Array<Int64>(codewordBytes.size, {n => Int64(codewordBytes[n]) & 0xFF})
        try {
            rsDecoder.decode(codewordsInts, codewordBytes.size - numDataCodewords)
        } catch (e: ReedSolomonException) {
            throw ChecksumException()
        }
        for (i in 0..numDataCodewords) {
            codewordBytes[i] = UInt8(codewordsInts[i])
        }
    }