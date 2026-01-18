    func crossCheckDiagonal(centerI: Int64, centerJ: Int64): Bool {
        let stateCount = getCrossCheckStateCount()

        var i = 0
        while (centerI >= i && centerJ >= i && image.get(centerJ - i, centerI - i)) {
            stateCount[2] += 1
            i++
        }
        if (stateCount[2] == 0) {
            return false
        }

        while (centerI >= i && centerJ >= i && !image.get(centerJ - i, centerI - i)) {
            stateCount[1] += 1
            i++
        }
        if (stateCount[1] == 0) {
            return false
        }

        while (centerI >= i && centerJ >= i && image.get(centerJ - i, centerI - i)) {
            stateCount[0] += 1
            i++
        }
        if (stateCount[0] == 0) {
            return false
        }

        let maxI = image.height
        let maxJ = image.width

        i = 1
        while (centerI + i < maxI && centerJ + i < maxJ && image.get(centerJ + i, centerI + i)) {
            stateCount[2] += 1
            i++
        }

        while (centerI + i < maxI && centerJ + i < maxJ && !image.get(centerJ + i, centerI + i)) {
            stateCount[3] += 1
            i++
        }
        if (stateCount[3] == 0) {
            return false
        }

        while (centerI + i < maxI && centerJ + i < maxJ && image.get(centerJ + i, centerI + i)) {
            stateCount[4] += 1
            i++
        }
        if (stateCount[4] == 0) {
            return false
        }

        foundPatternDiagonal(stateCount)
    }