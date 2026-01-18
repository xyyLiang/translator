  private static void embedPositionAdjustmentPattern(int xStart, int yStart, ByteMatrix matrix) {
    for (int y = 0; y < 5; ++y) {
      int[] patternY = POSITION_ADJUSTMENT_PATTERN[y];
      for (int x = 0; x < 5; ++x) {
        matrix.set(xStart + x, yStart + y, patternY[x]);
      }
    }
  }