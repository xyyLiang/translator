    protected static func parseFinderValue(counters: Array<Int64>, finderPatterns: Array<Array<Int64>>): Int64 {
        for (value in 0..finderPatterns.size) {
            if (patternMatchVariance(counters, finderPatterns[value], MAX_INDIVIDUAL_VARIANCE) < MAX_AVG_VARIANCE) {
                return value
            }
        }
        throw NotFoundException()
    }