  @Override
  public Result decodeRow(int rowNumber,
                          BitArray row,
                          Map<DecodeHintType,?> hints) throws NotFoundException, FormatException {
    // Rows can start with even pattern if previous rows had an odd number of patterns, so we try twice.
    this.startFromEven = false;
    try {
      return constructResult(decodeRow2pairs(rowNumber, row));
    } catch (NotFoundException e) {
      // OK
    }

    this.startFromEven = true;
    return constructResult(decodeRow2pairs(rowNumber, row));
  }