    func find(hints: ?HashMap<DecodeHintType, Any>): FinderPatternInfo {
        let tryHarder = if (let Some(h) = hints) {
            h.contains(DecodeHintType.TRY_HARDER)
        } else {
            false
        }

        let maxI = image.height
        let maxJ = image.width

        var iSkip = (3 * maxI) / (4 * MAX_MODULES)
        if (iSkip < MIN_SKIP || tryHarder) {
            iSkip = MIN_SKIP
        }

        var done = false
        let stateCount = Array<Int64>(5, item: 0)

        var i = iSkip - 1
        while (i < maxI && !done) {
            doClearCounts(stateCount)
            var currentState = 0
            var j = 0
            while (j < maxJ) {
                if (image.get(j, i)) {
                    if ((currentState & 1) == 1) {
                        currentState++
                    }
                    stateCount[currentState] += 1
                } else {
                    if ((currentState & 1) == 0) {
                        if (currentState == 4) {
                            if (foundPatternCross(stateCount)) {
                                let confirmed = handlePossibleCenter(stateCount, i, j)
                                if (confirmed) {
                                    iSkip = 2
                                    if (hasSkipped) {
                                        done = haveMultiplyConfirmedCenters()
                                    } else {
                                        let rowSkip = findRowSkip()
                                        if (rowSkip > stateCount[2]) {
                                            i += rowSkip - stateCount[2] - iSkip
                                            j = maxJ - 1
                                        }
                                    }
                                } else {
                                    doShiftCounts2(stateCount)
                                    currentState = 3
                                    j++
                                    continue
                                }

                                currentState = 0
                                doClearCounts(stateCount)
                            } else {
                                doShiftCounts2(stateCount)
                                currentState = 3
                            }
                        } else {
                            currentState++
                            stateCount[currentState] += 1
                        }
                    } else {
                        stateCount[currentState] += 1
                    }
                }
                j++
            }
            if (foundPatternCross(stateCount)) {
                let confirmed = handlePossibleCenter(stateCount, i, maxJ)
                if (confirmed) {
                    iSkip = stateCount[0]
                    if (hasSkipped) {
                        done = haveMultiplyConfirmedCenters()
                    }
                }
            }
            i += iSkip
        }

        let patternInfo = selectBestPatterns()
        orderBestPatterns(patternInfo)
        FinderPatternInfo(patternInfo)
    }