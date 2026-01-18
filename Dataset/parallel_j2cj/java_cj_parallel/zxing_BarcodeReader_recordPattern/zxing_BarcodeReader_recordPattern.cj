    protected static func recordPattern(row: BitArray, start: Int64, counters: Array<Int64>) {
        let numCounters = counters.size
        for (i in 0..numCounters) {
            counters[i] = 0
        }
        let end = row.size
        if (start >= end) {
            throw NotFoundException()
        }
        var isWhite = !row.get(start)
        var counterPosition = 0
        var i = start
        while (i < end) {
            if (row.get(i) != isWhite) {
                counters[counterPosition] += 1
            } else {
                counterPosition++
                if (counterPosition == numCounters) {
                    break
                } else {
                    counters[counterPosition] = 1
                    isWhite = !isWhite
                }
            }
            i++
        }

        if (!(counterPosition == numCounters || (counterPosition == numCounters - 1 && i == end))) {
            throw NotFoundException()
        }
    }