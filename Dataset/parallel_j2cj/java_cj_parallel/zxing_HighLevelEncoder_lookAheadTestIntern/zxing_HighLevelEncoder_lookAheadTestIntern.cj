    static func lookAheadTestIntern(msg: String, startPos: Int64, currentMode: Int64): Int64 {
        if (startPos >= msg.size) {
            return currentMode
        }
        let charCounts: Array<Float64> = if (currentMode == ASCII_ENCODATION) {
            [0.0, 1.0, 1.0, 1.0, 1.0, 1.25]
        } else {
            let charCounts = [1.0, 2.0, 2.0, 2.0, 2.0, 2.25]
            charCounts[currentMode] = 0.0
            charCounts
        }

        var charsProcessed = 0
        let mins = Array<UInt8>(6, item: 0)
        let intCharCounts = Array<Int64>(6, item: 0)
        while (true) {
            //step K
            if ((startPos + charsProcessed) == msg.size) {
                emptyMins.copyTo(mins, 0, 0, emptyMins.size)
                emptyIntCharCounts.copyTo(intCharCounts, 0, 0, emptyIntCharCounts.size)
                let min = findMinimums(charCounts, intCharCounts, Int64.Max, mins)
                let minCount = getMinimumCount(mins)

                if (intCharCounts[ASCII_ENCODATION] == min) {
                    return ASCII_ENCODATION
                }
                if (minCount == 1) {
                    if (mins[BASE256_ENCODATION] > 0) {
                        return BASE256_ENCODATION
                    }
                    if (mins[EDIFACT_ENCODATION] > 0) {
                        return EDIFACT_ENCODATION
                    }
                    if (mins[TEXT_ENCODATION] > 0) {
                        return TEXT_ENCODATION
                    }
                    if (mins[X12_ENCODATION] > 0) {
                        return X12_ENCODATION
                    }
                }
                return C40_ENCODATION
            }

            let c = msg.charAt(startPos + charsProcessed)
            charsProcessed++

            //step L
            if (isDigit(c)) {
                charCounts[ASCII_ENCODATION] += 0.5
            } else if (isExtendedASCII(c)) {
                charCounts[ASCII_ENCODATION] = math.ceil(charCounts[ASCII_ENCODATION])
                charCounts[ASCII_ENCODATION] += 2.0
            } else {
                charCounts[ASCII_ENCODATION] = math.ceil(charCounts[ASCII_ENCODATION])
                charCounts[ASCII_ENCODATION] += 1.0
            }

            //step M
            if (isNativeC40(c)) {
                charCounts[C40_ENCODATION] += 2.0 / 3.0
            } else if (isExtendedASCII(c)) {
                charCounts[C40_ENCODATION] += 8.0 / 3.0
            } else {
                charCounts[C40_ENCODATION] += 4.0 / 3.0
            }

            //step N
            if (isNativeText(c)) {
                charCounts[TEXT_ENCODATION] += 2.0 / 3.0
            } else if (isExtendedASCII(c)) {
                charCounts[TEXT_ENCODATION] += 8.0 / 3.0
            } else {
                charCounts[TEXT_ENCODATION] += 4.0 / 3.0
            }

            //step O
            if (isNativeX12(c)) {
                charCounts[X12_ENCODATION] += 2.0 / 3.0
            } else if (isExtendedASCII(c)) {
                charCounts[X12_ENCODATION] += 13.0 / 3.0
            } else {
                charCounts[X12_ENCODATION] += 10.0 / 3.0
            }

            //step P
            if (isNativeEDIFACT(c)) {
                charCounts[EDIFACT_ENCODATION] += 3.0 / 4.0
            } else if (isExtendedASCII(c)) {
                charCounts[EDIFACT_ENCODATION] += 17.0 / 4.0
            } else {
                charCounts[EDIFACT_ENCODATION] += 13.0 / 4.0
            }

            // step Q
            if (isSpecialB256(c)) {
                charCounts[BASE256_ENCODATION] += 4.0
            } else {
                charCounts[BASE256_ENCODATION] += 1.0
            }

            //step R
            if (charsProcessed >= 4) {
                emptyMins.copyTo(mins, 0, 0, emptyMins.size)
                emptyIntCharCounts.copyTo(intCharCounts, 0, 0, emptyIntCharCounts.size)
                findMinimums(charCounts, intCharCounts, Int64.Max, mins)

                if (intCharCounts[ASCII_ENCODATION] < min(
                    intCharCounts[BASE256_ENCODATION],
                    intCharCounts[C40_ENCODATION],
                    intCharCounts[TEXT_ENCODATION],
                    intCharCounts[X12_ENCODATION],
                    intCharCounts[EDIFACT_ENCODATION]
                )) {
                    return ASCII_ENCODATION
                }
                if (intCharCounts[BASE256_ENCODATION] < intCharCounts[ASCII_ENCODATION] ||
                    intCharCounts[BASE256_ENCODATION] + 1 < min(
                    intCharCounts[C40_ENCODATION],
                    intCharCounts[TEXT_ENCODATION],
                    intCharCounts[X12_ENCODATION],
                    intCharCounts[EDIFACT_ENCODATION]
                )) {
                    return BASE256_ENCODATION
                }
                if (intCharCounts[EDIFACT_ENCODATION] + 1 < min(
                    intCharCounts[BASE256_ENCODATION],
                    intCharCounts[C40_ENCODATION],
                    intCharCounts[TEXT_ENCODATION],
                    intCharCounts[X12_ENCODATION],
                    intCharCounts[ASCII_ENCODATION]
                )) {
                    return EDIFACT_ENCODATION
                }
                if (intCharCounts[TEXT_ENCODATION] + 1 < min(
                    intCharCounts[BASE256_ENCODATION],
                    intCharCounts[C40_ENCODATION],
                    intCharCounts[EDIFACT_ENCODATION],
                    intCharCounts[X12_ENCODATION],
                    intCharCounts[ASCII_ENCODATION]
                )) {
                    return TEXT_ENCODATION
                }
                if (intCharCounts[X12_ENCODATION] + 1 < min(
                    intCharCounts[BASE256_ENCODATION],
                    intCharCounts[C40_ENCODATION],
                    intCharCounts[EDIFACT_ENCODATION],
                    intCharCounts[TEXT_ENCODATION],
                    intCharCounts[ASCII_ENCODATION]
                )) {
                    return X12_ENCODATION
                }
                if (intCharCounts[C40_ENCODATION] + 1 < min(
                    intCharCounts[ASCII_ENCODATION],
                    intCharCounts[BASE256_ENCODATION],
                    intCharCounts[EDIFACT_ENCODATION],
                    intCharCounts[TEXT_ENCODATION]
                )) {
                    if (intCharCounts[C40_ENCODATION] < intCharCounts[X12_ENCODATION]) {
                        return C40_ENCODATION
                    }
                    if (intCharCounts[C40_ENCODATION] == intCharCounts[X12_ENCODATION]) {
                        var p = startPos + charsProcessed + 1
                        while (p < msg.size) {
                            let tc = msg.charAt(p)
                            if (isX12TermSep(tc)) {
                                return X12_ENCODATION
                            }
                            if (!isNativeX12(tc)) {
                                break
                            }
                            p++
                        }
                        return C40_ENCODATION
                    }
                }
            }
        }
        0
    }