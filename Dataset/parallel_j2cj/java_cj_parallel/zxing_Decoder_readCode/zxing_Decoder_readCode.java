  private static int readCode(boolean[] rawbits, int startIndex, int length) {
    int res = 0;
    for (int i = startIndex; i < startIndex + length; i++) {
      res <<= 1;
      if (rawbits[i]) {
        res |= 0x01;
      }
    }
    return res;
  }