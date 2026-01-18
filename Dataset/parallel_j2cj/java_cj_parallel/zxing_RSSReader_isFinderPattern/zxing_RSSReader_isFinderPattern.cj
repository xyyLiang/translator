    protected static func isFinderPattern(counters: Array<Int64>): Bool {
        let firstTwoSum = Float64(counters[0] + counters[1])
        let sum = firstTwoSum + Float64(counters[2] + counters[3])
        let ratio = firstTwoSum / sum
        if (ratio >= MIN_FINDER_PATTERN_RATIO && ratio <= MAX_FINDER_PATTERN_RATIO) {
            var minCounter = Int64.Max
            var maxCounter = Int64.Min
            for (counter in counters) {
                if (counter > maxCounter) {
                    maxCounter = counter
                }
                if (counter < minCounter) {
                    minCounter = counter
                }
            }
            maxCounter < 10 * minCounter
        } else {
            false
        }
    }