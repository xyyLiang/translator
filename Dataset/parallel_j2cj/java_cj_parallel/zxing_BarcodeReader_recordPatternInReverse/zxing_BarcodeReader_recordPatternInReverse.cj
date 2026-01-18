    protected static func recordPatternInReverse(row: BitArray, oStart: Int64, counters: Array<Int64>) {
        var numTransitionsLeft = counters.size
        var start = oStart
        var last = row.get(start)
        while (start > 0 && numTransitionsLeft >= 0) {
            start--
            if (row.get(start) != last) {
                numTransitionsLeft--
                last = !last
            }
        }
        if (numTransitionsLeft >= 0) {
            throw NotFoundException()
        }
        recordPattern(row, start + 1, counters)
    }