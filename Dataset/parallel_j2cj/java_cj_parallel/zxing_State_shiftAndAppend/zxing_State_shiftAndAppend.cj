    func shiftAndAppend(mode: Int64, value: Int64): State {
        var token = this.token
        let thisModeBitCount = if (this.mode == HighLevelEncoder.MODE_DIGIT) {
            4
        } else {
            5
        }
        token = token.add(HighLevelEncoder.SHIFT_TABLE[this.mode][mode], thisModeBitCount)
        token = token.add(value, 5)
        State(token, this.mode, 0, this.bitCount + thisModeBitCount + 5)
    }