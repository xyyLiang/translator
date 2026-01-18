    func decode(parser: BitMatrixParser, hints: ?HashMap<DecodeHintType, Any>): DecoderResult {
        let version = parser.readVersion()
        let ecLevel = parser.readFormatInformation().errorCorrectionLevel

        let codewords = parser.readCodewords()
        let dataBlocks = getDataBlocks(codewords, version, ecLevel)
        var totalBytes = 0
        for (dataBlock in dataBlocks) {
            totalBytes += dataBlock.numDataCodewords
        }
        let resultBytes = Array<UInt8>(totalBytes, item: 0)
        var resultOffset = 0

        for (dataBlock in dataBlocks) {
            let codewordBytes = dataBlock.codewords
            let numDataCodewords = dataBlock.numDataCodewords
            correctErrors(codewordBytes, numDataCodewords)
            for (i in 0..numDataCodewords) {
                resultBytes[resultOffset] = codewordBytes[i]
                resultOffset++
            }
        }
        decode(resultBytes, version, ecLevel, hints)
    }