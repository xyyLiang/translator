    func latchAndAppend(mode: Int64, value: Int64): State {
        var bitCount = this.bitCount
        var token = this.token
        if (mode != this.mode) {
            let latch = HighLevelEncoder.LATCH_TABLE[this.mode][mode]
            token = token.add(latch & 0xFFFF, latch >> 16)
            bitCount += latch >> 16
        }
        let latchModeBitCount = if (mode == HighLevelEncoder.MODE_DIGIT) {
            4
        } else {
            5
        }
        token = token.add(value, latchModeBitCount)
        State(token, mode, 0, bitCount + latchModeBitCount)
    }