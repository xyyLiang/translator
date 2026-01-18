  @Override
  public byte[] getRow(int y, byte[] row) {
    row = delegate.getRow(y, row);
    int width = getWidth();
    for (int i = 0; i < width; i++) {
      row[i] = (byte) (255 - (row[i] & 0xFF));
    }
    return row;
  }