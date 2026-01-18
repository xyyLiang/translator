  private static boolean isWhiteVertical(byte[][] array, int col, int from, int to) {
    if (from < 0 || array.length < to) {
      return false;
    }
    for (int i = from; i < to; i++) {
      if (array[i][col] == 1) {
        return false;
      }
    }
    return true;
  }