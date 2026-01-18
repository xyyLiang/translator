  private static int unescapedCharRev(String s, int rightIncl) {
    if (rightIncl < 0) {
      return 0;
    }
    // \?
    // \01
    // \012
    // \x00
    // \u0000
    for (int i = 1; i < 6; ++i) {
      int left = rightIncl - i;
      if (left < 0) { break; }
      if (s.charAt(left) == '\\') {
        // If there are an odd number of '\\' then decode.
        int n = 1;
        while (left - n >= 0 && s.charAt(left - n) == '\\') {
          ++n;
        }
        if ((n & 1) == 1) {
          int unescaped = unescapedChar(s, left);
          if ((unescaped >>> 16) - 1 == i) {
            return unescaped;
          }
        }
        break;
      }
    }
    return 0x10000 | s.charAt(rightIncl);
  }
