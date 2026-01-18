    static func decodeCode(row: BitArray, counters: Array<Int64>, rowOffset: Int64): Int64 {
        recordPattern(row, rowOffset, counters)
        var bestVariance = MAX_AVG_VARIANCE
        var bestMatch = -1
        for (d in 0..CODE_PATTERNS.size) {
            let pattern = CODE_PATTERNS[d]
            let variance = patternMatchVariance(counters, pattern, MAX_INDIVIDUAL_VARIANCE)
            if (variance < bestVariance) {
                bestVariance = variance
                bestMatch = d
            }
        }
        if (bestMatch >= 0) {
            return bestMatch
        }
        throw NotFoundException()
    }