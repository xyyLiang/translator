    public override func parseInformation(): String {
        let buff = StringBuilder()

        buff.append("(01)")
        let initialGtinPosition = buff.size
        let firstGtinDigit = this.generalDecoder.extractNumericValueFromBitArray(HEADER_SIZE, 4)
        buff.append(firstGtinDigit)

        this.encodeCompressedGtinWithoutAI(buff, HEADER_SIZE + 4, initialGtinPosition)

        this.generalDecoder.decodeAllCodes(buff, HEADER_SIZE + 44)
    }