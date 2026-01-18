    @overflowWrapping
    func correctErrors(codewordBytes: Array<UInt8>, start: Int64, dataCodewords: Int64, ecCodewords: Int64, mode: Int64) {
        let codewords = dataCodewords + ecCodewords

        let divisor = if (mode == ALL) {
            1
        } else {
            2
        }

        let codewordsInts = Array<Int64>(codewords / divisor, item: 0)
        for (i in 0..codewords) {
            if ((mode == ALL) || (i % 2 == (mode - 1))) {
                codewordsInts[i / divisor] = Int64(codewordBytes[i + start]) & 0xFF
            }
        }
        try {
            rsDecoder.decode(codewordsInts, ecCodewords / divisor)
        } catch (ignored: ReedSolomonException) {
            throw ChecksumException()
        }
        for (i in 0..dataCodewords) {
            if ((mode == ALL) || (i % 2 == (mode - 1))) {
                codewordBytes[i + start] = UInt8(codewordsInts[i / divisor])
            }
        }
    }