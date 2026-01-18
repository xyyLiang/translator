    static func findGuardPattern(row: BitArray, rowOffset: Int64, pattern: Array<Int64>): Array<Int64> {
        let patternLength = pattern.size
        let counters = Array<Int64>(patternLength, item: 0)
        let width = row.size
        var isWhite = false

        var counterPosition = 0
        var patternStart = rowOffset
        for (x in rowOffset..width) {
            if (row.get(x) != isWhite) {
                counters[counterPosition] += 1
            } else {
                if (counterPosition == patternLength - 1) {
                    if (patternMatchVariance(counters, pattern, MAX_INDIVIDUAL_VARIANCE) < MAX_AVG_VARIANCE) {
                        return [patternStart, x]
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