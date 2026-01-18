  @Override
  public Result decodeRow(int rowNumber, BitArray row, Map<DecodeHintType,?> hints) throws NotFoundException {

    Arrays.fill(counters, 0);
    setCounters(row);
    int startOffset = findStartPattern();
    int nextStart = startOffset;

    decodeRowResult.setLength(0);
    do {
      int charOffset = toNarrowWidePattern(nextStart);
      if (charOffset == -1) {
        throw NotFoundException.getNotFoundInstance();
      }
      // Hack: We store the position in the alphabet table into a
      // StringBuilder, so that we can access the decoded patterns in
      // validatePattern. We'll translate to the actual characters later.
      decodeRowResult.append((char) charOffset);
      nextStart += 8;
      // Stop as soon as we see the end character.
      if (decodeRowResult.length() > 1 &&
          arrayContains(STARTEND_ENCODING, ALPHABET[charOffset])) {
        break;
      }
    } while (nextStart < counterLength); // no fixed end pattern so keep on reading while data is available

    // Look for whitespace after pattern:
    int trailingWhitespace = counters[nextStart - 1];
    int lastPatternSize = 0;
    for (int i = -8; i < -1; i++) {
      lastPatternSize += counters[nextStart + i];
    }

    // We need to see whitespace equal to 50% of the last pattern size,
    // otherwise this is probably a false positive. The exception is if we are
    // at the end of the row. (I.e. the barcode barely fits.)
    if (nextStart < counterLength && trailingWhitespace < lastPatternSize / 2) {
      throw NotFoundException.getNotFoundInstance();
    }

    validatePattern(startOffset);

    // Translate character table offsets to actual characters.
    for (int i = 0; i < decodeRowResult.length(); i++) {
      decodeRowResult.setCharAt(i, ALPHABET[decodeRowResult.charAt(i)]);
    }
    // Ensure a valid start and end character
    char startchar = decodeRowResult.charAt(0);
    if (!arrayContains(STARTEND_ENCODING, startchar)) {
      throw NotFoundException.getNotFoundInstance();
    }
    char endchar = decodeRowResult.charAt(decodeRowResult.length() - 1);
    if (!arrayContains(STARTEND_ENCODING, endchar)) {
      throw NotFoundException.getNotFoundInstance();
    }

    // remove stop/start characters character and check if a long enough string is contained
    if (decodeRowResult.length() <= MIN_CHARACTER_LENGTH) {
      // Almost surely a false positive ( start + stop + at least 1 character)
      throw NotFoundException.getNotFoundInstance();
    }

    if (hints == null || !hints.containsKey(DecodeHintType.RETURN_CODABAR_START_END)) {
      decodeRowResult.deleteCharAt(decodeRowResult.length() - 1);
      decodeRowResult.deleteCharAt(0);
    }

    int runningCount = 0;
    for (int i = 0; i < startOffset; i++) {
      runningCount += counters[i];
    }
    float left = runningCount;
    for (int i = startOffset; i < nextStart - 1; i++) {
      runningCount += counters[i];
    }
    float right = runningCount;

    Result result = new Result(
        decodeRowResult.toString(),
        null,
        new ResultPoint[]{
            new ResultPoint(left, rowNumber),
            new ResultPoint(right, rowNumber)},
        BarcodeFormat.CODABAR);
    result.putMetadata(ResultMetadataType.SYMBOLOGY_IDENTIFIER, "]F0");
    return result;
  }