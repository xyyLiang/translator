    func crossCheckHorizontal(startJ: Int64, centerI: Int64, maxCount: Int64, originalStateCountTotal: Int64): Float64 {
        let maxJ = image.width
        let stateCount = getCrossCheckStateCount()

        var j = startJ
        while (j >= 0 && image.get(j, centerI)) {
            stateCount[2] += 1
            j--
        }
        if (j < 0) {
            return Float64.NaN
        }
        while (j >= 0 && !image.get(j, centerI) && stateCount[1] <= maxCount) {
            stateCount[1] += 1
            j--
        }
        if (j < 0 || stateCount[1] > maxCount) {
            return Float64.NaN
        }
        while (j >= 0 && image.get(j, centerI) && stateCount[0] <= maxCount) {
            stateCount[0] += 1
            j--
        }
        if (stateCount[0] > maxCount) {
            return Float64.NaN
        }

        j = startJ + 1
        while (j < maxJ && image.get(j, centerI)) {
            stateCount[2] += 1
            j++
        }
        if (j == maxJ) {
            return Float64.NaN
        }
        while (j < maxJ && !image.get(j, centerI) && stateCount[3] < maxCount) {
            stateCount[3] += 1
            j++
        }
        if (j == maxJ || stateCount[3] >= maxCount) {
            return Float64.NaN
        }
        while (j < maxJ && image.get(j, centerI) && stateCount[4] < maxCount) {
            stateCount[4] += 1
            j++
        }
        if (stateCount[4] >= maxCount) {
            return Float64.NaN
        }

        let stateCountTotal = stateCount[0] + stateCount[1] + stateCount[2] + stateCount[3] + stateCount[4]
        if (5 * math.abs(stateCountTotal - originalStateCountTotal) >= originalStateCountTotal) {
            return Float64.NaN
        }

        if (foundPatternCross(stateCount)) {
            centerFromEnd(stateCount, j)
        } else {
            return Float64.NaN
        }
    }