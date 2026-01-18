    func findFinderPattern(row: BitArray, rightFinderPattern: Bool): Array<Int64> {
        let counters = decodeFinderCounters
        counters[0] = 0
        counters[1] = 0
        counters[2] = 0
        counters[3] = 0

        let width = row.size
        var isWhite = false
        var rowOffset = 0
        while (rowOffset < width) {
            isWhite = !row.get(rowOffset)
            if (rightFinderPattern == isWhite) {
                break
            }
            rowOffset++
        }

        var counterPosition = 0
        var patternStart = rowOffset
        for (x in rowOffset..width) {
            if (row.get(x) != isWhite) {
                counters[counterPosition] += 1
            } else {
                if (counterPosition == 3) {
                    if (isFinderPattern(counters)) {
                        return [patternStart, x]
                    }
                    patternStart += counters[0] + counters[1]
                    counters[0] = counters[2]
                    counters[1] = counters[3]
                    counters[2] = 0
                    counters[3] = 0
                    counterPosition--
                } else {
                    counterPosition++
                }
                counters[counterPosition] = 1
                isWhite = !isWhite
            }
        }
        throw NotFoundException()
    }