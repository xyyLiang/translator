  private static int calculateNumberOfRows(int m, int k, int c) {
    int r = ((m + 1 + k) / c) + 1;
    if (c * r >= (m + 1 + k + c)) {
      r--;
    }
    return r;
  }