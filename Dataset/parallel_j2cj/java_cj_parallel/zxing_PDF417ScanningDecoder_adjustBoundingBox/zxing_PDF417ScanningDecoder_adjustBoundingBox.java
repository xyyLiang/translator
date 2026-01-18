  private static BoundingBox adjustBoundingBox(DetectionResultRowIndicatorColumn rowIndicatorColumn)
      throws NotFoundException {
    if (rowIndicatorColumn == null) {
      return null;
    }
    int[] rowHeights = rowIndicatorColumn.getRowHeights();
    if (rowHeights == null) {
      return null;
    }
    int maxRowHeight = getMax(rowHeights);
    int missingStartRows = 0;
    for (int rowHeight : rowHeights) {
      missingStartRows += maxRowHeight - rowHeight;
      if (rowHeight > 0) {
        break;
      }
    }
    Codeword[] codewords = rowIndicatorColumn.getCodewords();
    for (int row = 0; missingStartRows > 0 && codewords[row] == null; row++) {
      missingStartRows--;
    }
    int missingEndRows = 0;
    for (int row = rowHeights.length - 1; row >= 0; row--) {
      missingEndRows += maxRowHeight - rowHeights[row];
      if (rowHeights[row] > 0) {
        break;
      }
    }
    for (int row = codewords.length - 1; missingEndRows > 0 && codewords[row] == null; row--) {
      missingEndRows--;
    }
    return rowIndicatorColumn.getBoundingBox().addMissingRows(missingStartRows, missingEndRows,
        rowIndicatorColumn.isLeft());
  }
