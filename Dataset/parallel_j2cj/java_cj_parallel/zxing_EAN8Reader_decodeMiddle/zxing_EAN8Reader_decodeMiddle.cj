    protected func decodeMiddle(row: BitArray, startRange: Array<Int64>, result: StringBuilder): Int64 {
        let counters = decodeMiddleCounters
        counters[0] = 0
        counters[1] = 0
        counters[2] = 0
        counters[3] = 0
        let end = row.size
        var rowOffset = startRange[1]

        for (x in 0..4) {
            if (rowOffset >= end) {
                break
            }
            let bestMatch = decodeDigit(row, counters, rowOffset, L_PATTERNS)
            result.append(Char(UInt32('0') + UInt32(bestMatch)))
            for (counter in counters) {
                rowOffset += counter
            }
        }

        let middleRange = findGuardPattern(row, rowOffset, true, MIDDLE_PATTERN)
        rowOffset = middleRange[1]

        for (x in 0..4) {
            if (rowOffset >= end) {
                break
            }
            let bestMatch = decodeDigit(row, counters, rowOffset, L_PATTERNS)
            result.append(Char(UInt32('0') + UInt32(bestMatch)))
            for (counter in counters) {
                rowOffset += counter
            }
        }

        rowOffset
    }