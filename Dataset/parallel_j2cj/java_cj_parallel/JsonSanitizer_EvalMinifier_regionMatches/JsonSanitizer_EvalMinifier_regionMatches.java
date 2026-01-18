  static boolean regionMatches(
      CharSequence a, int as, int ae, CharSequence b, int bs, int be) {
    int n = ae - as;
    if (be - bs != n) { return false; }
    for (int ai = as, bi = bs; ai < ae; ++ai, ++bi) {
      if (a.charAt(ai) != b.charAt(bi)) { return false; }
    }
    return true;
  }