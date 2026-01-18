  public void rotate180() {
    BitArray topRow = new BitArray(width);
    BitArray bottomRow = new BitArray(width);
    int maxHeight = (height + 1) / 2;
    for (int i = 0; i < maxHeight; i++) {
      topRow = getRow(i, topRow);
      int bottomRowIndex = height - 1 - i;
      bottomRow = getRow(bottomRowIndex, bottomRow);
      topRow.reverse();
      bottomRow.reverse();
      setRow(i, bottomRow);
      setRow(bottomRowIndex, topRow);
    }
  }