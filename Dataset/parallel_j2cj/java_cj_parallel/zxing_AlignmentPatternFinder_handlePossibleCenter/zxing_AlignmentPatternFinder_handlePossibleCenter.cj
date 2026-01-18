    func handlePossibleCenter(stateCount: Array<Int64>, i: Int64, j: Int64): ?AlignmentPattern {
        let stateCountTotal = stateCount[0] + stateCount[1] + stateCount[2]
        let centerJ = centerFromEnd(stateCount, j)
        let centerI = crossCheckVertical(i, Int64(centerJ), 2 * stateCount[1], stateCountTotal)
        if (Float64.NaN != centerI) {
            let estimatedModuleSize = Float64(stateCount[0] + stateCount[1] + stateCount[2]) / 3.0
            for (center in possibleCenters) {
                if (center.aboutEquals(estimatedModuleSize, centerI, centerJ)) {
                    return center.combineEstimate(centerI, centerJ, estimatedModuleSize)
                }
            }
            let point = AlignmentPattern(centerJ, centerI, estimatedModuleSize)
            possibleCenters.append(point)
            if (let Some(r) = resultPointCallback) {
                r.foundPossibleResultPoint(point)
            }
        }
        None
    }