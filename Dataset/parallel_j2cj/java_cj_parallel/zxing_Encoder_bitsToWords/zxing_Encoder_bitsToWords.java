  private static int[] bitsToWords(BitArray stuffedBits, int wordSize, int totalWords) {
    int[] message = new int[totalWords];
    int i;
    int n;
    for (i = 0, n = stuffedBits.getSize() / wordSize; i < n; i++) {
      int value = 0;
      for (int j = 0; j < wordSize; j++) {
        value |= stuffedBits.get(i * wordSize + j) ? (1 << wordSize - j - 1) : 0;
      }
      message[i] = value;
    }
    return message;
  }