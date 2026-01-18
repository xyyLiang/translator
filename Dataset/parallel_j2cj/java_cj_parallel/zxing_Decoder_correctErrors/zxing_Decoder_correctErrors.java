  private int correctErrors(byte[] codewordBytes,
                             int start,
                             int dataCodewords,
                             int ecCodewords,
                             int mode) throws ChecksumException {
    int codewords = dataCodewords + ecCodewords;

    // in EVEN or ODD mode only half the codewords
    int divisor = mode == ALL ? 1 : 2;

    // First read into an array of ints
    int[] codewordsInts = new int[codewords / divisor];
    for (int i = 0; i < codewords; i++) {
      if ((mode == ALL) || (i % 2 == (mode - 1))) {
        codewordsInts[i / divisor] = codewordBytes[i + start] & 0xFF;
      }
    }
    int errorsCorrected = 0;
    try {
      errorsCorrected = rsDecoder.decodeWithECCount(codewordsInts, ecCodewords / divisor);
    } catch (ReedSolomonException ignored) {
      throw ChecksumException.getChecksumInstance();
    }
    // Copy back into array of bytes -- only need to worry about the bytes that were data
    // We don't care about errors in the error-correction codewords
    for (int i = 0; i < dataCodewords; i++) {
      if ((mode == ALL) || (i % 2 == (mode - 1))) {
        codewordBytes[i + start] = (byte) codewordsInts[i / divisor];
      }
    }
    return errorsCorrected;
  }
