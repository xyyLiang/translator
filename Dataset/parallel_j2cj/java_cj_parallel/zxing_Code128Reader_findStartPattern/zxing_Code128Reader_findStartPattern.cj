    static func findStartPattern(row: BitArray): Array<Int64> {
        let width = row.size
        let rowOffset = row.nextSet(0)

        var counterPosition = 0
        let counters = Array<Int64>(6, item: 0)
        var patternStart = rowOffset
        var isWhite = false
        let patternLength = counters.size

        for (i in rowOffset..width) {
            if (row.get(i) != isWhite) {
                counters[counterPosition] += 1
            } else {
                if (counterPosition == patternLength - 1) {
                    var bestVariance = MAX_AVG_VARIANCE
                    var bestMatch = -1
                    for (startCode in CODE_START_A..=CODE_START_C) {
                        let variance = patternMatchVariance(
                            counters,
                            CODE_PATTERNS[startCode],
                            MAX_INDIVIDUAL_VARIANCE
                        )
                        if (variance < bestVariance) {
                            bestVariance = variance
                            bestMatch = startCode
                        }
                    }
                    if (bestMatch >= 0 && row.isRange(
                        math.max(0, patternStart - (i - patternStart) / 2),
                        patternStart,
                        false
                    )) {
                        return [patternStart, i, bestMatch]
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