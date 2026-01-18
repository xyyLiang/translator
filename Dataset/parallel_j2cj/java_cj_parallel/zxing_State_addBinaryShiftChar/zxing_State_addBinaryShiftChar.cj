    func addBinaryShiftChar(index: Int64): State {
        var token = this.token
        var mode = this.mode
        var bitCount = this.bitCount
        if (this.mode == HighLevelEncoder.MODE_PUNCT || this.mode == HighLevelEncoder.MODE_DIGIT) {
            let latch = HighLevelEncoder.LATCH_TABLE[mode][HighLevelEncoder.MODE_UPPER]
            token = token.add(latch & 0xFFFF, latch >> 16)
            bitCount += latch >> 16
            mode = HighLevelEncoder.MODE_UPPER
        }
        let deltaBitCount = if (binaryShiftByteCount == 0 || binaryShiftByteCount == 31) {
            18
        } else if (binaryShiftByteCount == 62) {
            9
        } else {
            8
        }
        var result = State(token, mode, binaryShiftByteCount + 1, bitCount + deltaBitCount)
        if (result.binaryShiftByteCount == 2047 + 31) {
            result = result.endBinaryShift(index + 1)
        }
        result
    }
