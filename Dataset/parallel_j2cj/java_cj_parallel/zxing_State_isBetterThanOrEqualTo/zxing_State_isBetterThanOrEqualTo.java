  boolean isBetterThanOrEqualTo(State other) {
    int newModeBitCount = this.bitCount + (HighLevelEncoder.LATCH_TABLE[this.mode][other.mode] >> 16);
    if (this.binaryShiftByteCount < other.binaryShiftByteCount) {
      // add additional B/S encoding cost of other, if any
      newModeBitCount += other.binaryShiftCost - this.binaryShiftCost;
    } else if (this.binaryShiftByteCount > other.binaryShiftByteCount && other.binaryShiftByteCount > 0) {
      // maximum possible additional cost (we end up exceeding the 31 byte boundary and other state can stay beneath it)
      newModeBitCount += 10;
    }
    return newModeBitCount <= other.bitCount;
  }