  static int getDecodedValue(int[] moduleBitCount) {
    int decodedValue = getDecodedCodewordValue(sampleBitCounts(moduleBitCount));
    if (decodedValue != -1) {
      return decodedValue;
    }
    return getClosestDecodedValue(moduleBitCount);
  }