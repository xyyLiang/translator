  State endBinaryShift(int index) {
    if (binaryShiftByteCount == 0) {
      return this;
    }
    Token token = this.token;
    token = token.addBinaryShift(index - binaryShiftByteCount, binaryShiftByteCount);
    return new State(token, mode, 0, this.bitCount);
  }