    static func constructResult(leftPair: Pair, rightPair: Pair): Result {
        let symbolValue = 4537077 * leftPair.value + rightPair.value
        let text = "${symbolValue}"

        let buffer = StringBuilder()
        for (i in (13 - text.size)..0 : -1) {
            buffer.append('0')
        }
        buffer.append(text)

        var checkDigit = 0
        for (i in 0..13) {
            let digit = Int64(UInt32(buffer.get(i).getOrThrow())) - Int64(UInt32('0'))
            checkDigit += if ((i & 0x01) == 0) {
                3 * digit
            } else {
                digit
            }
        }
        checkDigit = 10 - (checkDigit % 10)
        if (checkDigit == 10) {
            checkDigit = 0
        }
        buffer.append(checkDigit)

        let leftPoints = leftPair.finderPattern.resultPoints
        let rightPoints = rightPair.finderPattern.resultPoints
        let result = Result(
            buffer.toString(),
            None,
            [leftPoints[0], leftPoints[1], rightPoints[0], rightPoints[1]],
            BarcodeFormat.RSS_14
        )
        result.putMetadata(ResultMetadataType.SYMBOLOGY_IDENTIFIER, "]e0")
        result
    }
