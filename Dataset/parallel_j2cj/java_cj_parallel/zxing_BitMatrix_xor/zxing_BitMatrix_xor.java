  public void xor(BitMatrix mask) {
    if (width != mask.width || height != mask.height || rowSize != mask.rowSize) {
      throw new IllegalArgumentException("input matrix dimensions do not match");
    }
    BitArray rowArray = new BitArray(width);
    for (int y = 0; y < height; y++) {
      int offset = y * rowSize;
      int[] row = mask.getRow(y, rowArray).getBitArray();
      for (int x = 0; x < rowSize; x++) {
        bits[offset + x] ^= row[x];
      }
    }
  }