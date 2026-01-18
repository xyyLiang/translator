    func endBinaryShift(index: Int64): State {
        if (binaryShiftByteCount == 0) {
            this
        } else {
            let token = this.token.addBinaryShift(index - binaryShiftByteCount, binaryShiftByteCount)
            State(token, mode, 0, this.bitCount)
        }
    }