  private static int[] getBitCountForCodeword(int codeword) {
    int[] result = new int[8];
    int previousValue = 0;
    int i = result.length - 1;
    while (true) {
      if ((codeword & 0x1) != previousValue) {
        previousValue = codeword & 0x1;
        i--;
        if (i < 0) {
          break;
        }
      }
      result[i]++;
      codeword >>= 1;
    }
    return result;
  }
