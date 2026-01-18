    func parseNumericBlock(): BlockParsedResult {
        while (isStillNumeric(current.position)) {
            let numeric = decodeNumeric(current.position)
            current.position = numeric.newPosition

            if (numeric.isFirstDigitFNC1()) {
                let information = if (numeric.isSecondDigitFNC1()) {
                    DecodedInformation(current.position, buffer.toString())
                } else {
                    DecodedInformation(current.position, buffer.toString(), numeric.secondDigit)
                }
                return BlockParsedResult(information, true)
            }
            buffer.append(numeric.firstDigit)

            if (numeric.isSecondDigitFNC1()) {
                let information = DecodedInformation(current.position, buffer.toString())
                return BlockParsedResult(information, true)
            }
            buffer.append(numeric.secondDigit)
        }

        if (isNumericToAlphaNumericLatch(current.position)) {
            current.setAlpha()
            current.incrementPosition(4)
        }
        BlockParsedResult()
    }