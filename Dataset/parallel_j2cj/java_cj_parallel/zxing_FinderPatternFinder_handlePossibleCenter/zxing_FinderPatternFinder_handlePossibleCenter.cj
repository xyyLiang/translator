    @overflowWrapping
    protected func handlePossibleCenter(stateCount: Array<Int64>, i: Int64, j: Int64): Bool {
        let stateCountTotal = stateCount[0] + stateCount[1] + stateCount[2] + stateCount[3] + stateCount[4]

        var centerJ = centerFromEnd(stateCount, j)
        let centerI = crossCheckVertical(i, Int64(centerJ), stateCount[2], stateCountTotal)
        if (!centerI.isNaN()) {
            centerJ = crossCheckHorizontal(Int64(centerJ), Int64(centerI), stateCount[2], stateCountTotal)
            if (!centerJ.isNaN() && crossCheckDiagonal(Int64(centerI), Int64(centerJ))) {
                let estimatedModuleSize = Float64(stateCountTotal) / 7.0
                var found = false
                for (index in 0..possibleCenters.size) {
                    let center = possibleCenters[index]
                    if (center.aboutEquals(estimatedModuleSize, centerI, centerJ)) {
                        possibleCenters.set(index, center.combineEstimate(centerI, centerJ, estimatedModuleSize))
                        found = true
                        break
                    }
                }
                if (!found) {
                    let point = FinderPattern(centerJ, centerI, estimatedModuleSize)
                    possibleCenters.append(point)
                    if (let Some(r) = resultPointCallback) {
                        r.foundPossibleResultPoint(point)
                    }
                }
                return true
            }
        }
        false
    }