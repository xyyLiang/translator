    static func decodeDigit(counters: Array<Int64>): Int64 {
        var bestVariance = MAX_AVG_VARIANCE
        var bestMatch = -1
        for (i in 0..PATTERNS.size) {
            let pattern = PATTERNS[i]
            let variance = patternMatchVariance(counters, pattern, MAX_INDIVIDUAL_VARIANCE)
            if (variance < bestVariance) {
                bestVariance = variance
                bestMatch = i
            } else if (variance == bestVariance) {
                bestMatch = -1
            }
        }
        if (bestMatch >= 0) {
            bestMatch % 10
        } else {
            throw NotFoundException()
        }
    }