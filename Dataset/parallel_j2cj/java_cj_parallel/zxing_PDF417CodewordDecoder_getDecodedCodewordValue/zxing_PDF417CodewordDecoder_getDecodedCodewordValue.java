  private static int getDecodedCodewordValue(int[] moduleBitCount) {
    int decodedValue = getBitValue(moduleBitCount);
    return PDF417Common.getCodeword(decodedValue) == -1 ? -1 : decodedValue;
  }