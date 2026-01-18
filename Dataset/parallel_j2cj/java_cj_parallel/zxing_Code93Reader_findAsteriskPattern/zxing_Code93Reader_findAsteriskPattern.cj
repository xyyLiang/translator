    func findAsteriskPattern(row: BitArray): Array<Int64> {
        let width = row.size
        let rowOffset = row.nextSet(0)

        for (i in 0..counters.size) {
            counters[i] = 0
        }
        let theCounters = counters
        var patternStart = rowOffset
        var isWhite = false
        let patternLength = theCounters.size

        var counterPosition = 0
        for (i in rowOffset..width) {
            if (row.get(i) != isWhite) {
                theCounters[counterPosition] += 1
            } else {
                if (counterPosition == patternLength - 1) {
                    if (toPattern(theCounters) == ASTERISK_ENCODING) {
                        return [patternStart, i]
                    }
                    patternStart += theCounters[0] + theCounters[1]
                    theCounters.copyTo(theCounters, 2, 0, counterPosition - 1)
                    theCounters[counterPosition - 1] = 0
                    theCounters[counterPosition] = 0
                    counterPosition--
                } else {
                    counterPosition++
                }
                theCounters[counterPosition] = 1
                isWhite = !isWhite
            }
        }
        throw NotFoundException()
    }