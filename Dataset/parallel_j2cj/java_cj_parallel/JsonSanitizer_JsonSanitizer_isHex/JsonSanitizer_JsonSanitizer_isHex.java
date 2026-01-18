  private static boolean isHex(char ch) {
    if ('0' <= ch && ch <= '9') { return true; }
    int lch = ch | 32;
    return 'a' <= lch && lch <= 'f';
  }