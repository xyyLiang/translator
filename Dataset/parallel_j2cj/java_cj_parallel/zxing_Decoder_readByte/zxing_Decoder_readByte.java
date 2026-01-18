  private static byte readByte(boolean[] rawbits, int startIndex) {
    int n = rawbits.length - startIndex;
    if (n >= 8) {
      return (byte) readCode(rawbits, startIndex, 8);
    }
    return (byte) (readCode(rawbits, startIndex, n) << (8 - n));
  }