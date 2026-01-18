    func decodeDataCharacter(row: BitArray, pattern: FinderPattern, outsideChar: Bool): DataCharacter {
        let counters = dataCharacterCounters
        for (i in 0..counters.size) {
            counters[i] = 0
        }

        if (outsideChar) {
            recordPatternInReverse(row, pattern.startEnd[0], counters)
        } else {
            recordPattern(row, pattern.startEnd[1], counters)
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

        let numModules = if (outsideChar) {
            16
        } else {
            15
        }
        let elementWidth = Float64(sum(counters)) / Float64(numModules)

        let oddCounts = this.oddCounts
        let evenCounts = this.evenCounts
        let oddRoundingErrors = this.oddRoundingErrors
        let evenRoundingErrors = this.evenRoundingErrors

        for (i in 0..counters.size) {
            let value = Float64(counters[i]) / elementWidth
            var count = Int64(value + 0.5)
            count = if (count < 1) {
                1
            } else if (count > 8) {
                8
            } else {
                count
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

        adjustOddEvenCounts(outsideChar, numModules)

        var oddSum = 0
        var oddChecksumPortion = 0
        for (i in (oddCounts.size - 1)..=0 : -1) {
            oddChecksumPortion *= 9
            oddChecksumPortion += oddCounts[i]
            oddSum += oddCounts[i]
        }
        var evenChecksumPortion = 0
        var evenSum = 0
        for (i in (evenCounts.size - 1)..=0 : -1) {
            evenChecksumPortion *= 9
            evenChecksumPortion += evenCounts[i]
            evenSum += evenCounts[i]
        }
        let checksumPortion = oddChecksumPortion + 3 * evenChecksumPortion

        if (outsideChar) {
            if ((oddSum & 0x01) != 0 || oddSum > 12 || oddSum < 4) {
                throw NotFoundException()
            }
            let group = (12 - oddSum) / 2
            let oddWidest = OUTSIDE_ODD_WIDEST[group]
            let evenWidest = 9 - oddWidest
            let vOdd = getRSSValue(oddCounts, oddWidest, false)
            let vEven = getRSSValue(evenCounts, evenWidest, true)
            let tEven = OUTSIDE_EVEN_TOTAL_SUBSET[group]
            let gSum = OUTSIDE_GSUM[group]
            return DataCharacter(vOdd * tEven + vEven + gSum, checksumPortion)
        } else {
            if ((evenSum & 0x01) != 0 || evenSum > 10 || evenSum < 4) {
                throw NotFoundException()
            }
            let group = (10 - evenSum) / 2
            let oddWidest = INSIDE_ODD_WIDEST[group]
            let evenWidest = 9 - oddWidest
            let vOdd = getRSSValue(oddCounts, oddWidest, true)
            let vEven = getRSSValue(evenCounts, evenWidest, false)
            let tOdd = INSIDE_ODD_TOTAL_SUBSET[group]
            let gSum = INSIDE_GSUM[group]
            return DataCharacter(vEven * tOdd + vOdd + gSum, checksumPortion)
        }
    }