    func decodeMiddle(row: BitArray, startRange: Array<Int64>, resultString: StringBuilder): Int64 {
        let counters = decodeMiddleCounters
        counters[0] = 0
        counters[1] = 0
        counters[2] = 0
        counters[3] = 0
        let end = row.size
        var rowOffset = startRange[1]

        var lgPatternFound = 0

        for (x in 0..5) {
            if (rowOffset >= end) {
                break
            }
            let bestMatch = UPCEANReader.decodeDigit(row, counters, rowOffset, UPCEANReader.L_AND_G_PATTERNS)
            resultString.append(Char(UInt32('0') + UInt32(bestMatch % 10)))
            for (counter in counters) {
                rowOffset += counter
            }
            if (bestMatch >= 10) {
                lgPatternFound |= 1 << (4 - x)
            }
            if (x != 4) {
                rowOffset = row.nextSet(rowOffset)
                rowOffset = row.nextUnset(rowOffset)
            }
        }

        if (resultString.size != 5) {
            throw NotFoundException()
        }

        let checkDigit = determineCheckDigit(lgPatternFound)
        if (extensionChecksum(resultString.toString()) != checkDigit) {
            throw NotFoundException()
        }

        rowOffset
    }