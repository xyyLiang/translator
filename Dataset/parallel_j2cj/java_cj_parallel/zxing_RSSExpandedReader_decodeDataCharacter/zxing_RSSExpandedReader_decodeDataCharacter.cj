    func decodeDataCharacter(row: BitArray, pattern: ?FinderPattern, isOddPattern: Bool, leftChar: Bool): DataCharacter {
        let counters = this.dataCharacterCounters
        for (i in 0..counters.size) {
            counters[i] = 0
        }

        if (leftChar) {
            recordPatternInReverse(row, pattern.getOrThrow().startEnd[0], counters)
        } else {
            recordPattern(row, pattern.getOrThrow().startEnd[1], counters)
            var i = 0
            var j = counters.size - 1
            while (i < j) {
                let temp = counters[i]
                counters[i] = counters[j]
                counters[j] = temp
                i++
                j--
            }
        }

        let numModules = 17
        let elementWidth = Float64(util.sum(counters)) / Float64(numModules)

        let expectedElementWidth = Float64(pattern.getOrThrow().startEnd[1] - pattern.getOrThrow().startEnd[0]) / 15.0
        if (math.abs(elementWidth - expectedElementWidth) / expectedElementWidth > 0.3) {
            throw NotFoundException()
        }

        let oddCounts = this.oddCounts
        let evenCounts = this.evenCounts
        let oddRoundingErrors = this.oddRoundingErrors
        let evenRoundingErrors = this.evenRoundingErrors

        for (i in 0..counters.size) {
            let value = 1.0 * Float64(counters[i]) / elementWidth
            var count = Int64(value + 0.5)
            if (count < 1) {
                if (value < 0.3) {
                    throw NotFoundException()
                }
                count = 1
            } else if (count > 8) {
                if (value > 8.7) {
                    throw NotFoundException()
                }
                count = 8
            }
            let offset = i / 2
            if ((i & 0x01) == 0) {
                oddCounts[offset] = count
                oddRoundingErrors[offset] = value - Float64(count)
            } else {
                evenCounts[offset] = count
                evenRoundingErrors[offset] = value - Float64(count)
            }
        }

        let weightRowNumber = 
            4 * pattern.getOrThrow().value + if (isOddPattern) {
            0
        } else {
            2
        } + if (leftChar) {
            0
        } else {
            1
        } - 1

        var oddSum = 0
        var oddChecksumPortion = 0
        for (i in (oddCounts.size - 1)..-1) {
            if (isNotA1left(pattern, isOddPattern, leftChar)) {
                let weight = WEIGHTS[weightRowNumber][2 * i]
                oddChecksumPortion += oddCounts[i] * weight
            }
            oddSum += oddCounts[i]
        }
        var evenChecksumPortion = 0
        for (i in (evenCounts.size - 1)..-1) {
            if (isNotA1left(pattern, isOddPattern, leftChar)) {
                let weight = WEIGHTS[weightRowNumber][2 * i + 1]
                evenChecksumPortion += evenCounts[i] * weight
            }
        }
        let checksumPortion = oddChecksumPortion + evenChecksumPortion

        if ((oddSum & 0x01) != 0 || oddSum > 13 || oddSum < 4) {
            throw NotFoundException()
        }

        let group = (13 - oddSum) / 2
        let oddWidest = SYMBOL_WIDEST[group]
        let evenWidest = 9 - oddWidest
        let vOdd = getRSSValue(oddCounts, oddWidest, true)
        let vEven = getRSSValue(evenCounts, evenWidest, false)
        let tEven = EVEN_TOTAL_SUBSET[group]
        let gSum = GSUM[group]
        let value = vOdd * tEven + vEven + gSum

        DataCharacter(value, checksumPortion)
    }