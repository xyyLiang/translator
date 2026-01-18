  @Override
  public BitMatrix encode(String contents,
                          BarcodeFormat format,
                          int width,
                          int height,
                          Map<EncodeHintType,?> hints) throws WriterException {
    if (format != BarcodeFormat.PDF_417) {
      throw new IllegalArgumentException("Can only encode PDF_417, but got " + format);
    }

    PDF417 encoder = new PDF417();
    int margin = WHITE_SPACE;
    int errorCorrectionLevel = DEFAULT_ERROR_CORRECTION_LEVEL;
    boolean autoECI = false;

    if (hints != null) {
      if (hints.containsKey(EncodeHintType.PDF417_COMPACT)) {
        encoder.setCompact(Boolean.parseBoolean(hints.get(EncodeHintType.PDF417_COMPACT).toString()));
      }
      if (hints.containsKey(EncodeHintType.PDF417_COMPACTION)) {
        encoder.setCompaction(Compaction.valueOf(hints.get(EncodeHintType.PDF417_COMPACTION).toString()));
      }
      if (hints.containsKey(EncodeHintType.PDF417_DIMENSIONS)) {
        Dimensions dimensions = (Dimensions) hints.get(EncodeHintType.PDF417_DIMENSIONS);
        encoder.setDimensions(dimensions.getMaxCols(),
                              dimensions.getMinCols(),
                              dimensions.getMaxRows(),
                              dimensions.getMinRows());
      }
      if (hints.containsKey(EncodeHintType.MARGIN)) {
        margin = Integer.parseInt(hints.get(EncodeHintType.MARGIN).toString());
      }
      if (hints.containsKey(EncodeHintType.ERROR_CORRECTION)) {
        errorCorrectionLevel = Integer.parseInt(hints.get(EncodeHintType.ERROR_CORRECTION).toString());
      }
      if (hints.containsKey(EncodeHintType.CHARACTER_SET)) {
        Charset encoding = Charset.forName(hints.get(EncodeHintType.CHARACTER_SET).toString());
        encoder.setEncoding(encoding);
      }
      autoECI = hints.containsKey(EncodeHintType.PDF417_AUTO_ECI) &&
          Boolean.parseBoolean(hints.get(EncodeHintType.PDF417_AUTO_ECI).toString());
    }

    return bitMatrixFromEncoder(encoder, contents, errorCorrectionLevel, width, height, margin, autoECI);
  }
