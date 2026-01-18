  public final void place() {
    int pos = 0;
    int row = 4;
    int col = 0;

    do {
      // repeatedly first check for one of the special corner cases, then...
      if ((row == numrows) && (col == 0)) {
        corner1(pos++);
      }
      if ((row == numrows - 2) && (col == 0) && ((numcols % 4) != 0)) {
        corner2(pos++);
      }
      if ((row == numrows - 2) && (col == 0) && (numcols % 8 == 4)) {
        corner3(pos++);
      }
      if ((row == numrows + 4) && (col == 2) && ((numcols % 8) == 0)) {
        corner4(pos++);
      }
      // sweep upward diagonally, inserting successive characters...
      do {
        if ((row < numrows) && (col >= 0) && noBit(col, row)) {
          utah(row, col, pos++);
        }
        row -= 2;
        col += 2;
      } while (row >= 0 && (col < numcols));
      row++;
      col += 3;

      // and then sweep downward diagonally, inserting successive characters, ...
      do {
        if ((row >= 0) && (col < numcols) && noBit(col, row)) {
          utah(row, col, pos++);
        }
        row += 2;
        col -= 2;
      } while ((row < numrows) && (col >= 0));
      row += 3;
      col++;

      // ...until the entire array is scanned
    } while ((row < numrows) || (col < numcols));

    // Lastly, if the lower right-hand corner is untouched, fill in fixed pattern
    if (noBit(numcols - 1, numrows - 1)) {
      setBit(numcols - 1, numrows - 1, true);
      setBit(numcols - 2, numrows - 2, true);
    }
  }
