    static func decodeMiddle(
        row: BitArray,
        oPayloadStart: Int64,
        payloadEnd: Int64,
        resultString: StringBuilder
    ) {
        let counterDigitPair = Array<Int64>(10, item: 0)
        let counterBlack = Array<Int64>(5, item: 0)
        let counterWhite = Array<Int64>(5, item: 0)
        var payloadStart = oPayloadStart
        while (payloadStart < payloadEnd) {
            recordPattern(row, payloadStart, counterDigitPair)
            for (k in 0..5) {
                let twoK = 2 * k
                counterBlack[k] = counterDigitPair[twoK]
                counterWhite[k] = counterDigitPair[twoK + 1]
            }

            var bestMatch = decodeDigit(counterBlack)
            resultString.append(Char(UInt32('0') + UInt32(bestMatch)))
            bestMatch = decodeDigit(counterWhite)
            resultString.append(Char(UInt32('0') + UInt32(bestMatch)))

            for (counterDigit in counterDigitPair) {
                payloadStart += counterDigit
            }
        }
    }