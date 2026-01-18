  private void setBit(int col, int row, boolean bit) {
    bits[row * numcols + col] = (byte) (bit ? 1 : 0);
  }
