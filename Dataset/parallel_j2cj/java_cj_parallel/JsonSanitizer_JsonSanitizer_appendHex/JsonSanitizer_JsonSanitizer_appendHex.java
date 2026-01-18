  private void appendHex(int n, int nDigits) {
    for (int quadsToShift = nDigits; --quadsToShift >= 0;) {
      int dig = (n >>> (4 * quadsToShift)) & 0xf;
      sanitizedJson.append((char) (dig + (dig < 10 ? '0' : (char) ('a' - 10))));
    }
  }