  static int applyMaskPenaltyRule2(ByteMatrix matrix) {
    int penalty = 0;
    byte[][] array = matrix.getArray();
    int width = matrix.getWidth();
    int height = matrix.getHeight();
    for (int y = 0; y < height - 1; y++) {
      byte[] arrayY = array[y];
      for (int x = 0; x < width - 1; x++) {
        int value = arrayY[x];
        if (value == arrayY[x + 1] && value == array[y + 1][x] && value == array[y + 1][x + 1]) {
          penalty++;
        }
      }
    }
    return N2 * penalty;
  }