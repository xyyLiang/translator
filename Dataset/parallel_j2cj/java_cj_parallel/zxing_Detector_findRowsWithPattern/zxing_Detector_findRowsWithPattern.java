  private static ResultPoint[] findRowsWithPattern(BitMatrix matrix,
                                                   int height,
                                                   int width,
                                                   int startRow,
                                                   int startColumn,
                                                   int minHeight,
                                                   int[] pattern) {
    ResultPoint[] result = new ResultPoint[4];
    boolean found = false;
    int[] counters = new int[pattern.length];
    for (; startRow < height; startRow += ROW_STEP) {
      int[] loc = findGuardPattern(matrix, startColumn, startRow, width, pattern, counters);
      if (loc != null) {
        while (startRow > 0) {
          int[] previousRowLoc = findGuardPattern(matrix, startColumn, --startRow, width, pattern, counters);
          if (previousRowLoc != null) {
            loc = previousRowLoc;
          } else {
            startRow++;
            break;
          }
        }
        result[0] = new ResultPoint(loc[0], startRow);
        result[1] = new ResultPoint(loc[1], startRow);
        found = true;
        break;
      }
    }
    int stopRow = startRow + 1;
    // Last row of the current symbol that contains pattern
    if (found) {
      int skippedRowCount = 0;
      int[] previousRowLoc = {(int) result[0].getX(), (int) result[1].getX()};
      for (; stopRow < height; stopRow++) {
        int[] loc = findGuardPattern(matrix, previousRowLoc[0], stopRow, width, pattern, counters);
        // a found pattern is only considered to belong to the same barcode if the start and end positions
        // don't differ too much. Pattern drift should be not bigger than two for consecutive rows. With
        // a higher number of skipped rows drift could be larger. To keep it simple for now, we allow a slightly
        // larger drift and don't check for skipped rows.
        if (loc != null &&
            Math.abs(previousRowLoc[0] - loc[0]) < MAX_PATTERN_DRIFT &&
            Math.abs(previousRowLoc[1] - loc[1]) < MAX_PATTERN_DRIFT) {
          previousRowLoc = loc;
          skippedRowCount = 0;
        } else {
          if (skippedRowCount > SKIPPED_ROW_COUNT_MAX) {
            break;
          } else {
            skippedRowCount++;
          }
        }
      }
      stopRow -= skippedRowCount + 1;
      result[2] = new ResultPoint(previousRowLoc[0], stopRow);
      result[3] = new ResultPoint(previousRowLoc[1], stopRow);
    }
    if (stopRow - startRow < minHeight) {
      Arrays.fill(result, null);
    }
    return result;
  }
