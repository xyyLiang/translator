  private static boolean isWhiteHorizontal(byte[] rowArray, int from, int to) {
    if (from < 0 || rowArray.length < to) {
      return false;
    }
    for (int i = from; i < to; i++) {
      if (rowArray[i] == 1) {
        return false;
      }
    }
    return true;
  }