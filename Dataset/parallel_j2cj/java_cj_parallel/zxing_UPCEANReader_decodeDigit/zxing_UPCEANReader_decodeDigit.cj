    static func decodeDigit(row: BitArray, counters: Array<Int64>, rowOffset: Int64, patterns: Array<Array<Int64>>): Int64 {
        recordPattern(row, rowOffset, counters)
        var bestVariance = MAX_AVG_VARIANCE
        var bestMatch = -1
        for (i in 0..patterns.size) {
            let pattern = patterns[i]
            let variance = patternMatchVariance(counters, pattern, MAX_INDIVIDUAL_VARIANCE)
            if (variance < bestVariance) {
                bestVariance = variance
                bestMatch = i
            }
        }
        if (bestMatch >= 0) {
            bestMatch
        } else {
            throw NotFoundException()
        }
    }