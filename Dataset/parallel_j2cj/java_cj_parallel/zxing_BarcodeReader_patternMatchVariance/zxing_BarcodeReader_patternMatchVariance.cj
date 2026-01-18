    protected static func patternMatchVariance(
        counters: Array<Int64>,
        pattern: Array<Int64>,
        oMaxIndividualVariance: Float64
    ): Float64 {
        let numCounters = counters.size
        var total = 0
        var patternLength = 0
        for (i in 0..numCounters) {
            total += counters[i]
            patternLength += pattern[i]
        }
        if (total < patternLength) {
            return Float64.Inf
        }
        let unitBarWidth = Float64(total) / Float64(patternLength)
        let maxIndividualVariance = oMaxIndividualVariance * unitBarWidth
        var totalVariance = 0.0
        for (x in 0..numCounters) {
            let counter = Float64(counters[x])
            let scaledPattern = Float64(pattern[x]) * unitBarWidth
            let variance = if (counter > scaledPattern) {
                counter - scaledPattern
            } else {
                scaledPattern - counter
            }
            if (variance > maxIndividualVariance) {
                return Float64.Inf
            }
            totalVariance += variance
        }
        totalVariance / Float64(total)
    }