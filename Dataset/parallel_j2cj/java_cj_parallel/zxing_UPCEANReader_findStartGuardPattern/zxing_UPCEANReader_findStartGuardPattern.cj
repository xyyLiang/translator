    static func findStartGuardPattern(row: BitArray): Array<Int64> {
        var foundStart = false
        var startRange: Array<Int64> = []
        var nextStart = 0
        let counters = Array<Int64>(START_END_PATTERN.size, item: 0)
        while (!foundStart) {
            for (i in 0..counters.size) {
                counters[i] = 0
            }
            startRange = findGuardPattern(row, nextStart, false, START_END_PATTERN, counters)
            let start = startRange[0]
            nextStart = startRange[1]
            let quietStart = start - (nextStart - start)
            if (quietStart >= 0) {
                foundStart = row.isRange(quietStart, start, false)
            }
        }
        startRange
    }