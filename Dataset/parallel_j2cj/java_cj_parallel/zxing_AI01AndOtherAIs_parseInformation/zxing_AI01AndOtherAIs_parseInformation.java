  @Override
  public String parseInformation() throws NotFoundException, FormatException {
    StringBuilder buff = new StringBuilder();

    buff.append("(01)");
    int initialGtinPosition = buff.length();
    int firstGtinDigit = this.getGeneralDecoder().extractNumericValueFromBitArray(HEADER_SIZE, 4);
    buff.append(firstGtinDigit);

    this.encodeCompressedGtinWithoutAI(buff, HEADER_SIZE + 4, initialGtinPosition);

    return this.getGeneralDecoder().decodeAllCodes(buff, HEADER_SIZE + 44);
  }