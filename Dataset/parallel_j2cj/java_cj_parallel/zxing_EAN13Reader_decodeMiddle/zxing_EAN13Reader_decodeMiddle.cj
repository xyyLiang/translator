    protected func decodeMiddle(
        row: BitArray,
        startRange: Array<Int64>,
        resultString: StringBuilder
    ): Int64 {
        let counters = decodeMiddleCounters
        counters[0] = 0
        counters[1] = 0
        counters[2] = 0
        counters[3] = 0
        let end = row.size
        var rowOffset = startRange[1]

        var lgPatternFound = 0

        for (x in 0..6) {
            if (rowOffset >= end) {
                break
            }
            let bestMatch = decodeDigit(row, counters, rowOffset, L_AND_G_PATTERNS)
            resultString.append(Char(UInt32('0') + UInt32(bestMatch % 10)))
            for (counter in counters) {
                rowOffset += counter
            }
            if (bestMatch >= 10) {
                lgPatternFound |= 1 << (5 - x)
            }
        }

        determineFirstDigit(resultString, lgPatternFound)

        let middleRange = findGuardPattern(row, rowOffset, true, MIDDLE_PATTERN)
        rowOffset = middleRange[1]

        for (x in 0..6) {
            if (rowOffset >= end) {
                break
            }
            let bestMatch = decodeDigit(row, counters, rowOffset, L_PATTERNS)
            resultString.append(Char(UInt32('0') + UInt32(bestMatch)))
            for (counter in counters) {
                rowOffset += counter
            }
        }

        rowOffset
    }