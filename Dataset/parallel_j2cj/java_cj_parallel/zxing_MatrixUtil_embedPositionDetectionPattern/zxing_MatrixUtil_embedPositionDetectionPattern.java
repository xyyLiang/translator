  private static void embedPositionDetectionPattern(int xStart, int yStart, ByteMatrix matrix) {
    for (int y = 0; y < 7; ++y) {
      int[] patternY = POSITION_DETECTION_PATTERN[y];
      for (int x = 0; x < 7; ++x) {
        matrix.set(xStart + x, yStart + y, patternY[x]);
      }
    }
  }