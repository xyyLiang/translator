  public static int getCodeword(int symbol) {
    int i = Arrays.binarySearch(SYMBOL_TABLE, symbol & 0x3FFFF);
    if (i < 0) {
      return -1;
    }
    return (CODEWORD_TABLE[i] - 1) % NUMBER_OF_CODEWORDS;
  }