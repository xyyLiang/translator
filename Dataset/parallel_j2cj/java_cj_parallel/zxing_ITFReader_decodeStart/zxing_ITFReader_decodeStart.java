  private int[] decodeStart(BitArray row) throws NotFoundException {
    int endStart = skipWhiteSpace(row);
    int[] startPattern = findGuardPattern(row, endStart, START_PATTERN);

    // Determine the width of a narrow line in pixels. We can do this by
    // getting the width of the start pattern and dividing by 4 because its
    // made up of 4 narrow lines.
    this.narrowLineWidth = (startPattern[1] - startPattern[0]) / 4;

    validateQuietZone(row, startPattern[0]);

    return startPattern;
  }