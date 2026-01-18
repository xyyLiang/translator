    func crossCheckVertical(startI: Int64, centerJ: Int64, maxCount: Int64, originalStateCountTotal: Int64): Float64 {
        let maxI = image.height
        let stateCount = crossCheckStateCount
        stateCount[0] = 0
        stateCount[1] = 0
        stateCount[2] = 0

        var i = startI
        while (i >= 0 && image.get(centerJ, i) && stateCount[1] <= maxCount) {
            stateCount[1] += 1
            i--
        }

        if (i < 0 || stateCount[1] > maxCount) {
            return Float64.NaN
        }
        while (i >= 0 && !image.get(centerJ, i) && stateCount[0] <= maxCount) {
            stateCount[0] += 1
            i--
        }
        if (stateCount[0] > maxCount) {
            return Float64.NaN
        }

        i = startI + 1
        while (i < maxI && image.get(centerJ, i) && stateCount[1] <= maxCount) {
            stateCount[1] += 1
            i++
        }
        if (i == maxI || stateCount[1] > maxCount) {
            return Float64.NaN
        }
        while (i < maxI && !image.get(centerJ, i) && stateCount[2] <= maxCount) {
            stateCount[2] += 1
            i++
        }
        if (stateCount[2] > maxCount) {
            return Float64.NaN
        }

        let stateCountTotal = stateCount[0] + stateCount[1] + stateCount[2]
        if (5 * math.abs(stateCountTotal - originalStateCountTotal) >= 2 * originalStateCountTotal) {
            return Float64.NaN
        }

        if (foundPatternCross(stateCount)) {
            centerFromEnd(stateCount, i)
        } else {
            Float64.NaN
        }
    }