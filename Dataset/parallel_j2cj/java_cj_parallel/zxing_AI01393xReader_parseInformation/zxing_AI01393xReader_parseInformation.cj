    public func parseInformation(): String {
        if (this.information.size < (HEADER_SIZE + GTIN_SIZE)) {
            throw NotFoundException()
        }

        let buf = StringBuilder()

        encodeCompressedGtin(buf, HEADER_SIZE)

        let lastAIdigit = this.generalDecoder.extractNumericValueFromBitArray(HEADER_SIZE + GTIN_SIZE, LAST_DIGIT_SIZE)
        buf.append("(393").append(lastAIdigit).append(')')

        let firstThreeDigits = this.generalDecoder.extractNumericValueFromBitArray(
            HEADER_SIZE + GTIN_SIZE + LAST_DIGIT_SIZE, FIRST_THREE_DIGITS_SIZE)
        if (firstThreeDigits / 100 == 0) {
            buf.append('0')
        }
        if (firstThreeDigits / 10 == 0) {
            buf.append('0')
        }
        buf.append(firstThreeDigits)

        let generalInformation = this.generalDecoder.decodeGeneralPurposeField(
            HEADER_SIZE + GTIN_SIZE + LAST_DIGIT_SIZE + FIRST_THREE_DIGITS_SIZE, None)
        buf.append(generalInformation.newString)

        buf.toString()
    }