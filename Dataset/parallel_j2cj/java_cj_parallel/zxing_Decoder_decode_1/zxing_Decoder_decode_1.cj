    public func decode(bits: BitMatrix, hints: ?HashMap<DecodeHintType, Any>): DecoderResult {
        let parser = BitMatrixParser(bits)
        let codewords = parser.readCodewords()
        correctErrors(codewords, 0, 10, 10, ALL)
        let mode = Int64(codewords[0]) & 0x0F
        let datawords = Array<UInt8>(
            match (mode) {
                case 2 | 3 | 4 =>
                    correctErrors(codewords, 20, 84, 40, EVEN)
                    correctErrors(codewords, 20, 84, 40, ODD)
                    94
                case 5 =>
                    correctErrors(codewords, 20, 68, 56, EVEN)
                    correctErrors(codewords, 20, 68, 56, ODD)
                    78
                case _ => throw FormatException()
            },
            item: 0
        )
        codewords.copyTo(datawords, 0, 0, 10)
        codewords.copyTo(datawords, 20, 10, datawords.size - 10)
        DecodedBitStreamParser.decode(datawords, mode)
    }