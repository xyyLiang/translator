  private static DecoderResult decodeCodewords(int[] codewords, int ecLevel, int[] erasures) throws FormatException,
      ChecksumException {
    if (codewords.length == 0) {
      throw FormatException.getFormatInstance();
    }

    int numECCodewords = 1 << (ecLevel + 1);
    int correctedErrorsCount = correctErrors(codewords, erasures, numECCodewords);
    verifyCodewordCount(codewords, numECCodewords);

    // Decode the codewords
    DecoderResult decoderResult = DecodedBitStreamParser.decode(codewords, String.valueOf(ecLevel));
    decoderResult.setErrorsCorrected(correctedErrorsCount);
    decoderResult.setErasures(erasures.length);
    return decoderResult;
  }
