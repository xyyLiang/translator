  private static void embedVerticalSeparationPattern(int xStart,
                                                     int yStart,
                                                     ByteMatrix matrix) throws WriterException {
    for (int y = 0; y < 7; ++y) {
      if (!isEmpty(matrix.get(xStart, yStart + y))) {
        throw new WriterException();
      }
      matrix.set(xStart, yStart + y, 0);
    }
  }