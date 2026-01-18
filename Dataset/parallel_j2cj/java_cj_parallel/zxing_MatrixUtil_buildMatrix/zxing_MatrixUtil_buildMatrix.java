  static void buildMatrix(BitArray dataBits,
                          ErrorCorrectionLevel ecLevel,
                          Version version,
                          int maskPattern,
                          ByteMatrix matrix) throws WriterException {
    clearMatrix(matrix);
    embedBasicPatterns(version, matrix);
    // Type information appear with any version.
    embedTypeInfo(ecLevel, maskPattern, matrix);
    // Version info appear if version >= 7.
    maybeEmbedVersionInfo(version, matrix);
    // Data should be embedded at end.
    embedDataBits(dataBits, maskPattern, matrix);
  }
