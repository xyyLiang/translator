  private int[] determineDimensions(int sourceCodeWords, int errorCorrectionCodeWords) throws WriterException {
    float ratio = 0.0f;
    int[] dimension = null;

    for (int cols = minCols; cols <= maxCols; cols++) {

      int rows = calculateNumberOfRows(sourceCodeWords, errorCorrectionCodeWords, cols);

      if (rows < minRows) {
        break;
      }

      if (rows > maxRows) {
        continue;
      }

      float newRatio = ((float) (17 * cols + 69) * DEFAULT_MODULE_WIDTH) / (rows * HEIGHT);

      // ignore if previous ratio is closer to preferred ratio
      if (dimension != null && Math.abs(newRatio - PREFERRED_RATIO) > Math.abs(ratio - PREFERRED_RATIO)) {
        continue;
      }

      ratio = newRatio;
      dimension = new int[] {cols, rows};
    }

    // Handle case when min values were larger than necessary
    if (dimension == null) {
      int rows = calculateNumberOfRows(sourceCodeWords, errorCorrectionCodeWords, minCols);
      if (rows < minRows) {
        dimension = new int[]{minCols, minRows};
      }
    }

    if (dimension == null) {
      throw new WriterException("Unable to fit message in columns");
    }

    return dimension;
  }
