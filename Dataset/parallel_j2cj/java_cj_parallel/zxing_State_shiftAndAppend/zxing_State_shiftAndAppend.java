  State shiftAndAppend(int mode, int value) {
    Token token = this.token;
    int thisModeBitCount = this.mode == HighLevelEncoder.MODE_DIGIT ? 4 : 5;
    // Shifts exist only to UPPER and PUNCT, both with tokens size 5.
    token = token.add(HighLevelEncoder.SHIFT_TABLE[this.mode][mode], thisModeBitCount);
    token = token.add(value, 5);
    return new State(token, this.mode, 0, this.bitCount + thisModeBitCount + 5);
  }