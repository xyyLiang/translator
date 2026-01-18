    func isBetterThanOrEqualTo(other: State): Bool {
        var newModeBitCount = this.bitCount + (HighLevelEncoder.LATCH_TABLE[this.mode][other.mode] >> 16)
        if (this.binaryShiftByteCount < other.binaryShiftByteCount) {
            newModeBitCount += other.binaryShiftCost - this.binaryShiftCost
        } else if (this.binaryShiftByteCount > other.binaryShiftByteCount && other.binaryShiftByteCount > 0) {
            newModeBitCount += 10
        }
        newModeBitCount <= other.bitCount
    }