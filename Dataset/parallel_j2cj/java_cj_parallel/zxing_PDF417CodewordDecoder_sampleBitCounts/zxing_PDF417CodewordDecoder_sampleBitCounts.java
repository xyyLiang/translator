  private static int[] sampleBitCounts(int[] moduleBitCount) {
    float bitCountSum = MathUtils.sum(moduleBitCount);
    int[] result = new int[PDF417Common.BARS_IN_MODULE];
    int bitCountIndex = 0;
    int sumPreviousBits = 0;
    for (int i = 0; i < PDF417Common.MODULES_IN_CODEWORD; i++) {
      float sampleIndex = 
          bitCountSum / (2 * PDF417Common.MODULES_IN_CODEWORD) +
          (i * bitCountSum) / PDF417Common.MODULES_IN_CODEWORD;
      if (sumPreviousBits + moduleBitCount[bitCountIndex] <= sampleIndex) {
        sumPreviousBits += moduleBitCount[bitCountIndex];
        bitCountIndex++;
      }
      result[bitCountIndex]++;
    }
    return result;
  }