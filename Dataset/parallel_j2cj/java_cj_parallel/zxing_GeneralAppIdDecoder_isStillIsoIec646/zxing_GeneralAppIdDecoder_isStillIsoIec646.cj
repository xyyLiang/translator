    func isStillIsoIec646(pos: Int64): Bool {
        if (pos + 5 > this.information.size) {
            return false
        }

        let fiveBitValue = extractNumericValueFromBitArray(pos, 5)
        if (fiveBitValue >= 5 && fiveBitValue < 16) {
            return true
        }

        if (pos + 7 > this.information.size) {
            return false
        }

        let sevenBitValue = extractNumericValueFromBitArray(pos, 7)
        if (sevenBitValue >= 64 && sevenBitValue < 116) {
            return true
        }

        if (pos + 8 > this.information.size) {
            return false
        }

        let eightBitValue = extractNumericValueFromBitArray(pos, 8)
        eightBitValue >= 232 && eightBitValue < 253
    }