    func findNextPair(row: BitArray, previousPairs: ArrayList<ExpandedPair>, forcedOffset: Int64) {
        let counters = this.decodeFinderCounters
        counters[0] = 0
        counters[1] = 0
        counters[2] = 0
        counters[3] = 0

        let width = row.size

        var rowOffset = if (forcedOffset >= 0) {
            forcedOffset
        } else if (previousPairs.isEmpty()) {
            0
        } else {
            let lastPair = previousPairs[previousPairs.size - 1]
            lastPair.finderPattern.getOrThrow().startEnd[1]
        }

        var searchingEvenPair = previousPairs.size % 2 != 0
        if (startFromEven) {
            searchingEvenPair = !searchingEvenPair
        }

        var isWhite = false
        while (rowOffset < width) {
            isWhite = !row.get(rowOffset)
            if (!isWhite) {
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
                    if (searchingEvenPair) {
                        reverseCounters(counters)
                    }

                    if (isFinderPattern(counters)) {
                        this.startEnd[0] = patternStart
                        this.startEnd[1] = x
                        return
                    }

                    if (searchingEvenPair) {
                        reverseCounters(counters)
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
