    func adjustOddEvenCounts(numModules: Int64) {
        let oddSum = sum(this.oddCounts)
        let evenSum = sum(this.evenCounts)

        var incrementOdd = false
        var decrementOdd = false

        if (oddSum > 13) {
            decrementOdd = true
        } else if (oddSum < 4) {
            incrementOdd = true
        }
        var incrementEven = false
        var decrementEven = false
        if (evenSum > 13) {
            decrementEven = true
        } else if (evenSum < 4) {
            incrementEven = true
        }
        let mismatch = oddSum + evenSum - numModules
        let oddParityBad = (oddSum & 0x01) == 1
        let evenParityBad = (evenSum & 0x01) == 0
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
            increment(this.oddCounts, this.oddRoundingErrors)
        }
        if (decrementOdd) {
            decrement(this.oddCounts, this.oddRoundingErrors)
        }
        if (incrementEven) {
            if (decrementEven) {
                throw NotFoundException()
            }
            increment(this.evenCounts, this.oddRoundingErrors)
        }
        if (decrementEven) {
            decrement(this.evenCounts, this.evenRoundingErrors)
        }
    }
