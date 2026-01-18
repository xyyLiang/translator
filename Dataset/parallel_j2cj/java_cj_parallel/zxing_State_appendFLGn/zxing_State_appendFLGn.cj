    func appendFLGn(eci: Int64): State {
        let result = shiftAndAppend(HighLevelEncoder.MODE_PUNCT, 0)
        var token = result.token
        var bitsAdded = 3
        if (eci < 0) {
            token = token.add(0, 3)
        } else if (eci > 999999) {
            throw IllegalArgumentException("ECI code must be between 0 and 999999")
        } else {
            let eciDigits = "${eci}".toUtf8Array()
            token = token.add(eciDigits.size, 3)
            for (eciDigit in eciDigits) {
                token = token.add(Int64(UInt32(eciDigit) - UInt32('0') + 2), 4)
            }
            bitsAdded += eciDigits.size * 4
        }
        State(token, mode, 0, bitCount + bitsAdded)
    }