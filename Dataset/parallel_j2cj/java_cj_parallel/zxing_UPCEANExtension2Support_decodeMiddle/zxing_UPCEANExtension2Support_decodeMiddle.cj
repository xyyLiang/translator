    func decodeMiddle(row: BitArray, startRange: Array<Int64>, resultString: StringBuilder): Int64 {
        let counters = decodeMiddleCounters
        counters[0] = 0
        counters[1] = 0
        counters[2] = 0
        counters[3] = 0
        let end = row.size
        var rowOffset = startRange[1]

        var checkParity = 0

        for (x in 0..2) {
            if (rowOffset >= end) {
                break
            }
            let bestMatch = UPCEANReader.decodeDigit(row, counters, rowOffset, UPCEANReader.L_AND_G_PATTERNS)
            resultString.append(Char(UInt32('0') + UInt32(bestMatch % 10)))
            for (counter in counters) {
                rowOffset += counter
            }
            if (bestMatch >= 10) {
                checkParity |= 1 << (1 - x)
            }
            if (x != 1) {
                rowOffset = row.nextSet(rowOffset)
                rowOffset = row.nextUnset(rowOffset)
            }
        }

        if (resultString.size != 2) {
            throw NotFoundException()
        }

        if (Int64.parse(resultString.toString()) % 4 != checkParity) {
            throw NotFoundException()
        }

        rowOffset
    }