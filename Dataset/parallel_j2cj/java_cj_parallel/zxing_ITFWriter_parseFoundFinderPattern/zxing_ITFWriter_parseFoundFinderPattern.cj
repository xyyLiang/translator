    func parseFoundFinderPattern(row: BitArray, rowNumber: Int64, right: Bool, startEnd: Array<Int64>): FinderPattern {
        let firstIsBlack = row.get(startEnd[0])
        var firstElementStart = startEnd[0] - 1
        while (firstElementStart >= 0 && firstIsBlack != row.get(firstElementStart)) {
            firstElementStart--
        }
        firstElementStart++
        let firstCounter = startEnd[0] - firstElementStart
        let counters = decodeFinderCounters
        counters.copyTo(counters, 0, 1, counters.size - 1)
        counters[0] = firstCounter
        let value = parseFinderValue(counters, FINDER_PATTERNS)
        var start = firstElementStart
        var end = startEnd[1]
        if (right) {
            start = row.size - 1 - start
            end = row.size - 1 - end
        }
        FinderPattern(value, [firstElementStart, startEnd[1]], start, end, rowNumber)
    }