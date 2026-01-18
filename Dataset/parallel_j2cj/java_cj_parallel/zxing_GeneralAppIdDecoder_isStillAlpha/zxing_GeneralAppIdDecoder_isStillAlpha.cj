    func isStillAlpha(pos: Int64): Bool {
        if (pos + 5 > this.information.size) {
            return false
        }

        let fiveBitValue = extractNumericValueFromBitArray(pos, 5)
        if (fiveBitValue >= 5 && fiveBitValue < 16) {
            return true
        }

        if (pos + 6 > this.information.size) {
            return false
        }

        let sixBitValue = extractNumericValueFromBitArray(pos, 6)
        sixBitValue >= 16 && sixBitValue < 63
    }