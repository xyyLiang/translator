  private static int correctErrors(int[] codewords, int[] erasures, int numECCodewords) throws ChecksumException {
    if (erasures != null &&
        erasures.length > numECCodewords / 2 + MAX_ERRORS ||
        numECCodewords < 0 ||
        numECCodewords > MAX_EC_CODEWORDS) {
      // Too many errors or EC Codewords is corrupted
      throw ChecksumException.getChecksumInstance();
    }
    return errorCorrection.decode(codewords, numECCodewords, erasures);
  }
