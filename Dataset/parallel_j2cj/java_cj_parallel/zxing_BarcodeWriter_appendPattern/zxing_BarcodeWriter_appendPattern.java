  protected static int appendPattern(boolean[] target, int pos, int[] pattern, boolean startColor) {
    boolean color = startColor;
    int numAdded = 0;
    for (int len : pattern) {
      for (int j = 0; j < len; j++) {
        target[pos++] = color;
      }
      numAdded += len;
      color = !color; // flip color after each segment
    }
    return numAdded;
  }