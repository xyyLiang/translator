  public final boolean getBit(int col, int row) {
    return bits[row * numcols + col] == 1;
  }