    static func findGuardPattern(
        row: BitArray,
        oRowOffset: Int64,
        whiteFirst: Bool,
        pattern: Array<Int64>,
        counters: Array<Int64>
    ): Array<Int64> {
        let width = row.size
        let rowOffset = if (whiteFirst) {
            row.nextUnset(oRowOffset)
        } else {
            row.nextSet(oRowOffset)
        }
        var counterPosition = 0
        var patternStart = rowOffset
        let patternLength = pattern.size
        var isWhite = whiteFirst
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