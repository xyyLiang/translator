  private static Codeword detectCodeword(BitMatrix image,
                                         int minColumn,
                                         int maxColumn,
                                         boolean leftToRight,
                                         int startColumn,
                                         int imageRow,
                                         int minCodewordWidth,
                                         int maxCodewordWidth) {
    startColumn = adjustCodewordStartColumn(image, minColumn, maxColumn, leftToRight, startColumn, imageRow);
    // we usually know fairly exact now how long a codeword is. We should provide minimum and maximum expected length
    // and try to adjust the read pixels, e.g. remove single pixel errors or try to cut off exceeding pixels.
    // min and maxCodewordWidth should not be used as they are calculated for the whole barcode an can be inaccurate
    // for the current position
    int[] moduleBitCount = getModuleBitCount(image, minColumn, maxColumn, leftToRight, startColumn, imageRow);
    if (moduleBitCount == null) {
      return null;
    }
    int endColumn;
    int codewordBitCount = MathUtils.sum(moduleBitCount);
    if (leftToRight) {
      endColumn = startColumn + codewordBitCount;
    } else {
      for (int i = 0; i < moduleBitCount.length / 2; i++) {
        int tmpCount = moduleBitCount[i];
        moduleBitCount[i] = moduleBitCount[moduleBitCount.length - 1 - i];
        moduleBitCount[moduleBitCount.length - 1 - i] = tmpCount;
      }
      endColumn = startColumn;
      startColumn = endColumn - codewordBitCount;
    }

    if (!checkCodewordSkew(codewordBitCount, minCodewordWidth, maxCodewordWidth)) {
      // We could try to use the startX and endX position of the codeword in the same column in the previous row,
      // create the bit count from it and normalize it to 8. This would help with single pixel errors.
      return null;
    }

    int decodedValue = PDF417CodewordDecoder.getDecodedValue(moduleBitCount);
    int codeword = PDF417Common.getCodeword(decodedValue);
    if (codeword == -1) {
      return null;
    }
    return new Codeword(startColumn, endColumn, getCodewordBucketNumber(decodedValue), codeword);
  }