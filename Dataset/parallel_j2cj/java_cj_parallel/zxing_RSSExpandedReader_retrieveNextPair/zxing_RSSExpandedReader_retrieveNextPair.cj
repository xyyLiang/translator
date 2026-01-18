    func retrieveNextPair(row: BitArray, previousPairs: ArrayList<ExpandedPair>, rowNumber: Int64): ExpandedPair {
        var isOddPattern = previousPairs.size % 2 == 0
        if (startFromEven) {
            isOddPattern = !isOddPattern
        }

        var pattern: ?FinderPattern = None

        var keepFinding = true
        var forcedOffset = -1
        do {
            this.findNextPair(row, previousPairs, forcedOffset)
            pattern = parseFoundFinderPattern(row, rowNumber, isOddPattern)
            if (let None = pattern) {
                forcedOffset = getNextSecondBar(row, this.startEnd[0])
            } else {
                keepFinding = false
            }
        } while (keepFinding)

        let leftChar = this.decodeDataCharacter(row, pattern, isOddPattern, true)

        if (!previousPairs.isEmpty() && previousPairs[previousPairs.size - 1].mustBeLast()) {
            throw NotFoundException()
        }

        let rightChar: ?DataCharacter = try {
            this.decodeDataCharacter(row, pattern, isOddPattern, false)
        } catch (e: NotFoundException) {
            None
        }
        ExpandedPair(leftChar, rightChar, pattern)
    }
