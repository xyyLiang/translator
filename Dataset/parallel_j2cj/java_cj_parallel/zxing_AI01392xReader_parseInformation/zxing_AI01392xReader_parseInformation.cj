    public func parseInformation(): String {
        if (this.information.size < (HEADER_SIZE + GTIN_SIZE)) {
            throw NotFoundException()
        }

        let buf = StringBuilder()

        encodeCompressedGtin(buf, HEADER_SIZE)

        let lastAIdigit = this.generalDecoder.extractNumericValueFromBitArray(HEADER_SIZE + GTIN_SIZE, LAST_DIGIT_SIZE)
        buf.append("(392").append(lastAIdigit).append(')')

        let generalInformation = this.generalDecoder.decodeGeneralPurposeField(HEADER_SIZE + GTIN_SIZE + LAST_DIGIT_SIZE,
            None)
        buf.append(generalInformation.newString)

        buf.toString()
    }