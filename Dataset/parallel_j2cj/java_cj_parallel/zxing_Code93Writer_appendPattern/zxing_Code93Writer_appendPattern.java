  @Deprecated
  protected static int appendPattern(boolean[] target, int pos, int[] pattern, boolean startColor) {
    for (int bit : pattern) {
      target[pos++] = bit != 0;
    }
    return 9;
  }