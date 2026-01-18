    static func findAsteriskPattern(row: BitArray, counters: Array<Int64>): Array<Int64> {
        let width = row.size
        let rowOffset = row.nextSet(0)

        var counterPosition = 0
        var patternStart = rowOffset
        var isWhite = false
        var patternLength = counters.size

        for (i in rowOffset..width) {
            if (row.get(i) != isWhite) {
                counters[counterPosition] += 1
            } else {
                if (counterPosition == patternLength - 1) {
                    if (toNarrowWidePattern(counters) == ASTERISK_ENCODING && row.isRange(
                        math.max(0, patternStart - ((i - patternStart) / 2)), patternStart, false)) {
                        return [patternStart, i]
                    }
                    patternStart += counters[0] + counters[1]
                    counters.copyTo(counters, 2, 0, counterPosition - 1)
                    counters[counterPosition - 1] = 0
                    counters[counterPosition] = 0
                    counterPosition--
                } else {
                    counterPosition++
                }
                counters[counterPosition] = 1
                isWhite = !isWhite
            }
        }
        throw NotFoundException()
    }