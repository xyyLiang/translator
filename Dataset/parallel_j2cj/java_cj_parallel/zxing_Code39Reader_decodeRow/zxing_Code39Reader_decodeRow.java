  @Override
  public Result decodeRow(int rowNumber, BitArray row, Map<DecodeHintType,?> hints)
      throws NotFoundException, ChecksumException, FormatException {

    int[] theCounters = counters;
    Arrays.fill(theCounters, 0);
    StringBuilder result = decodeRowResult;
    result.setLength(0);

    int[] start = findAsteriskPattern(row, theCounters);
    // Read off white space
    int nextStart = row.getNextSet(start[1]);
    int end = row.getSize();

    char decodedChar;
    int lastStart;
    do {
      recordPattern(row, nextStart, theCounters);
      int pattern = toNarrowWidePattern(theCounters);
      if (pattern < 0) {
        throw NotFoundException.getNotFoundInstance();
      }
      decodedChar = patternToChar(pattern);
      result.append(decodedChar);
      lastStart = nextStart;
      for (int counter : theCounters) {
        nextStart += counter;
      }
      // Read off white space
      nextStart = row.getNextSet(nextStart);
    } while (decodedChar != '*');
    result.setLength(result.length() - 1); // remove asterisk

    // Look for whitespace after pattern:
    int lastPatternSize = 0;
    for (int counter : theCounters) {
      lastPatternSize += counter;
    }
    int whiteSpaceAfterEnd = nextStart - lastStart - lastPatternSize;
    // If 50% of last pattern size, following last pattern, is not whitespace, fail
    // (but if it's whitespace to the very end of the image, that's OK)
    if (nextStart != end && (whiteSpaceAfterEnd * 2) < lastPatternSize) {
      throw NotFoundException.getNotFoundInstance();
    }

    if (usingCheckDigit) {
      int max = result.length() - 1;
      int total = 0;
      for (int i = 0; i < max; i++) {
        total += ALPHABET_STRING.indexOf(decodeRowResult.charAt(i));
      }
      if (result.charAt(max) != ALPHABET_STRING.charAt(total % 43)) {
        throw ChecksumException.getChecksumInstance();
      }
      result.setLength(max);
    }

    if (result.length() == 0) {
      // false positive
      throw NotFoundException.getNotFoundInstance();
    }

    String resultString;
    if (extendedMode) {
      resultString = decodeExtended(result);
    } else {
      resultString = result.toString();
    }

    float left = (start[1] + start[0]) / 2.0f;
    float right = lastStart + lastPatternSize / 2.0f;

    Result resultObject = new Result(
        resultString,
        null,
        new ResultPoint[]{
            new ResultPoint(left, rowNumber),
            new ResultPoint(right, rowNumber)},
        BarcodeFormat.CODE_39);
    resultObject.putMetadata(ResultMetadataType.SYMBOLOGY_IDENTIFIER, "]A0");
    return resultObject;
  }
