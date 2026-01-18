    func parseFoundFinderPattern(row: BitArray, rowNumber: Int64, oddPattern: Bool): ?FinderPattern {
        let (firstCounter, start, end) = if (oddPattern) {
            var firstElementStart = this.startEnd[0] - 1
            while (firstElementStart >= 0 && !row.get(firstElementStart)) {
                firstElementStart--
            }

            firstElementStart++
            (this.startEnd[0] - firstElementStart, firstElementStart, this.startEnd[1])
        } else {
            let s = this.startEnd[0]
            let e = row.nextUnset(this.startEnd[1] + 1)
            (e - this.startEnd[1], s, e)
        }

        let counters = this.decodeFinderCounters
        counters.copyTo(counters, 0, 1, counters.size - 1)
        counters[0] = firstCounter

        try {
            let value = parseFinderValue(counters, FINDER_PATTERNS)
            FinderPattern(value, [start, end], start, end, rowNumber)
        } catch (e: NotFoundException) {
            None
        }
    }
