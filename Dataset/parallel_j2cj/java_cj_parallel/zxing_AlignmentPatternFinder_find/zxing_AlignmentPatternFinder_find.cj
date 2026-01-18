    func find(): AlignmentPattern {
        let startX = this.startX
        let height = this.height
        let maxJ = startX + width
        let middleI = startY + (height / 2)

        let stateCount = Array<Int64>(3, item: 0)
        for (iGen in 0..height) {
            let i = middleI + if ((iGen & 0x01) == 0) {
                (iGen + 1) / 2
            } else {
                -((iGen + 1) / 2)
            }
            stateCount[0] = 0
            stateCount[1] = 0
            stateCount[2] = 0
            var j = startX
            while (j < maxJ && !image.get(j, i)) {
                j++
            }
            var currentState = 0
            while (j < maxJ) {
                if (image.get(j, i)) {
                    if (currentState == 1) {
                        stateCount[1] += 1
                    } else {
                        if (currentState == 2) {
                            if (foundPatternCross(stateCount)) {
                                let confirmed = handlePossibleCenter(stateCount, i, j)
                                if (let Some(c) = confirmed) {
                                    return c
                                }
                            }
                            stateCount[0] = stateCount[2]
                            stateCount[1] = 1
                            stateCount[2] = 0
                            currentState = 1
                        } else {
                            currentState++
                            stateCount[currentState] += 1
                        }
                    }
                } else {
                    if (currentState == 1) {
                        currentState++
                    }
                    stateCount[currentState] += 1
                }
                j++
            }
            if (foundPatternCross(stateCount)) {
                let confirmed = handlePossibleCenter(stateCount, i, maxJ)
                if (let Some(c) = confirmed) {
                    return c
                }
            }
        }

        if (!possibleCenters.isEmpty()) {
            return possibleCenters[0]
        }
        throw NotFoundException()
    }