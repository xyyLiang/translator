  private void module(int row, int col, int pos, int bit) {
    if (row < 0) {
      row += numrows;
      col += 4 - ((numrows + 4) % 8);
    }
    if (col < 0) {
      col += numcols;
      row += 4 - ((numcols + 4) % 8);
    }
    // Note the conversion:
    int v = codewords.charAt(pos);
    v &= 1 << (8 - bit);
    setBit(col, row, v != 0);
  }