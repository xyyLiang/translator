  static int applyMaskPenaltyRule4(ByteMatrix matrix) {
    int numDarkCells = 0;
    byte[][] array = matrix.getArray();
    int width = matrix.getWidth();
    int height = matrix.getHeight();
    for (int y = 0; y < height; y++) {
      byte[] arrayY = array[y];
      for (int x = 0; x < width; x++) {
        if (arrayY[x] == 1) {
          numDarkCells++;
        }
      }
    }
    int numTotalCells = matrix.getHeight() * matrix.getWidth();
    int fivePercentVariances = Math.abs(numDarkCells * 2 - numTotalCells) * 10 / numTotalCells;
    return fivePercentVariances * N4;
  }