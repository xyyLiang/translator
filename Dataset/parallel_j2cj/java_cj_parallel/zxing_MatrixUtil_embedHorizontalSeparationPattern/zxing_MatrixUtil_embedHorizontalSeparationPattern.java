  private static void embedHorizontalSeparationPattern(int xStart,
                                                       int yStart,
                                                       ByteMatrix matrix) throws WriterException {
    for (int x = 0; x < 8; ++x) {
      if (!isEmpty(matrix.get(xStart + x, yStart))) {
        throw new WriterException();
      }
      matrix.set(xStart + x, yStart, 0);
    }
  }