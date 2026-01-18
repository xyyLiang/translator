    func adjustOddEvenCounts(outsideChar: Bool, numModules: Int64) {
        let oddSum = sum(oddCounts)
        let evenSum = sum(evenCounts)

        var incrementOdd = false
        var decrementOdd = false
        var incrementEven = false
        var decrementEven = false

        if (outsideChar) {
            if (oddSum > 12) {
                decrementOdd = true
            } else if (oddSum < 4) {
                incrementOdd = true
            }
            if (evenSum > 12) {
                decrementEven = true
            } else if (evenSum < 4) {
                incrementEven = true
            }
        } else {
            if (oddSum > 11) {
                decrementOdd = true
            } else if (oddSum < 5) {
                incrementOdd = true
            }
            if (evenSum > 10) {
                decrementEven = true
            } else if (evenSum < 4) {
                incrementEven = true
            }
        }

        let mismatch = oddSum + evenSum - numModules
        let oddParityBad = (oddSum & 0x01) == (if (outsideChar) {
            1
        } else {
            0
        })
        let evenParityBad = (evenSum & 0x01) == 1

        match (mismatch) {
            case 1 =>
                if (oddParityBad) {
                    if (evenParityBad) {
                        throw NotFoundException()
                    }
                    decrementOdd = true
                } else {
                    if (!evenParityBad) {
                        throw NotFoundException()
                    }
                    decrementEven = true
                }
            case -1 =>
                if (oddParityBad) {
                    if (evenParityBad) {
                        throw NotFoundException()
                    }
                    incrementOdd = true
                } else {
                    if (!evenParityBad) {
                        throw NotFoundException()
                    }
                    incrementEven = true
                }
            case 0 =>
                if (oddParityBad) {
                    if (!evenParityBad) {
                        throw NotFoundException()
                    }
                    if (oddSum < evenSum) {
                        incrementOdd = true
                        decrementEven = true
                    } else {
                        decrementOdd = true
                        incrementEven = true
                    }
                } else {
                    if (evenParityBad) {
                        throw NotFoundException()
                    }
                }
            case _ => throw NotFoundException()
        }

        if (incrementOdd) {
            if (decrementOdd) {
                throw NotFoundException()
            }
            increment(oddCounts, oddRoundingErrors)
        }
        if (decrementOdd) {
            decrement(oddCounts, oddRoundingErrors)
        }
        if (incrementEven) {
            if (decrementEven) {
                throw NotFoundException()
            }
            increment(evenCounts, oddRoundingErrors)
        }
        if (decrementEven) {
            decrement(evenCounts, evenRoundingErrors)
        }
    }