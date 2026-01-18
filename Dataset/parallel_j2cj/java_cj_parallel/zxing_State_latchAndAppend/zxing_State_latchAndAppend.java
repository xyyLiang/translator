  State latchAndAppend(int mode, int value) {
    int bitCount = this.bitCount;
    Token token = this.token;
    if (mode != this.mode) {
      int latch = HighLevelEncoder.LATCH_TABLE[this.mode][mode];
      token = token.add(latch & 0xFFFF, latch >> 16);
      bitCount += latch >> 16;
    }
    int latchModeBitCount = mode == HighLevelEncoder.MODE_DIGIT ? 4 : 5;
    token = token.add(value, latchModeBitCount);
    return new State(token, mode, 0, bitCount + latchModeBitCount);
  }