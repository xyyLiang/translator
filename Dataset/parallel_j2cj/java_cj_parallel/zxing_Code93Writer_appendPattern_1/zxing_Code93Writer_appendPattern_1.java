  private static int appendPattern(boolean[] target, int pos, int a) {
    for (int i = 0; i < 9; i++) {
      int temp = a & (1 << (8 - i));
      target[pos + i] = temp != 0;
    }
    return 9;
  }