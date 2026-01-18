  private static int getNumberOfPadCodewords(int m, int k, int c, int r) {
    int n = c * r - k;
    return n > m + 1 ? n - m - 1 : 0;
  }
