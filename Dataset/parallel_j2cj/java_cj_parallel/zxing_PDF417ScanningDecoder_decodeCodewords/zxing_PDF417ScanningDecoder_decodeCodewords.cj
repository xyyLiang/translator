    static func decodeCodewords(codewords: Array<Int64>, ecLevel: Int64, erasures: Array<Int64>): DecoderResult {
        if (codewords.size == 0) {
            throw FormatException()
        }

        let numECCodewords = 1 << (ecLevel + 1)
        let correctedErrorsCount = correctErrors(codewords, erasures, numECCodewords)
        verifyCodewordCount(codewords, numECCodewords)

        let decoderResult = DecodedBitStreamParser.decode(codewords, "${ecLevel}")
        decoderResult.errorsCorrected = correctedErrorsCount
        decoderResult.erasures = erasures.size
        decoderResult
    }