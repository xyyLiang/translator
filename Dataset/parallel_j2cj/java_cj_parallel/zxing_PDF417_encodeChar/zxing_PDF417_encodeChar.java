  private static void encodeChar(int pattern, int len, BarcodeRow logic) {
    int map = 1 << len - 1;
    boolean last = (pattern & map) != 0; //Initialize to inverse of first bit
    int width = 0;
    for (int i = 0; i < len; i++) {
      boolean black = (pattern & map) != 0;
      if (last == black) {
        width++;
      } else {
        logic.addBar(last, width);

        last = black;
        width = 1;
      }
      map >>= 1;
    }
    logic.addBar(last, width);
  }
