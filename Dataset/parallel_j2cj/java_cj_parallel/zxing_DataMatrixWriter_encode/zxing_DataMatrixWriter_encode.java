  @Override
  public BitMatrix encode(String contents, BarcodeFormat format, int width, int height, Map<EncodeHintType,?> hints) {

    if (contents.isEmpty()) {
      throw new IllegalArgumentException("Found empty contents");
    }

    if (format != BarcodeFormat.DATA_MATRIX) {
      throw new IllegalArgumentException("Can only encode DATA_MATRIX, but got " + format);
    }

    if (width < 0 || height < 0) {
      throw new IllegalArgumentException("Requested dimensions can't be negative: " + width + 'x' + height);
    }

    // Try to get force shape & min / max size
    SymbolShapeHint shape = SymbolShapeHint.FORCE_NONE;
    Dimension minSize = null;
    Dimension maxSize = null;
    if (hints != null) {
      SymbolShapeHint requestedShape = (SymbolShapeHint) hints.get(EncodeHintType.DATA_MATRIX_SHAPE);
      if (requestedShape != null) {
        shape = requestedShape;
      }
      @SuppressWarnings("deprecation")
      Dimension requestedMinSize = (Dimension) hints.get(EncodeHintType.MIN_SIZE);
      if (requestedMinSize != null) {
        minSize = requestedMinSize;
      }
      @SuppressWarnings("deprecation")
      Dimension requestedMaxSize = (Dimension) hints.get(EncodeHintType.MAX_SIZE);
      if (requestedMaxSize != null) {
        maxSize = requestedMaxSize;
      }
    }


    //1. step: Data encodation
    String encoded;

    boolean hasCompactionHint = hints != null && hints.containsKey(EncodeHintType.DATA_MATRIX_COMPACT) &&
        Boolean.parseBoolean(hints.get(EncodeHintType.DATA_MATRIX_COMPACT).toString());
    if (hasCompactionHint) {

      boolean hasGS1FormatHint = hints.containsKey(EncodeHintType.GS1_FORMAT) &&
          Boolean.parseBoolean(hints.get(EncodeHintType.GS1_FORMAT).toString());

      Charset charset = null;
      boolean hasEncodingHint = hints.containsKey(EncodeHintType.CHARACTER_SET);
      if (hasEncodingHint) {
        charset = Charset.forName(hints.get(EncodeHintType.CHARACTER_SET).toString());
      }
      encoded = MinimalEncoder.encodeHighLevel(contents, charset, hasGS1FormatHint ? 0x1D : -1, shape);
    } else {
      boolean hasForceC40Hint = hints != null && hints.containsKey(EncodeHintType.FORCE_C40) &&
          Boolean.parseBoolean(hints.get(EncodeHintType.FORCE_C40).toString());
      encoded = HighLevelEncoder.encodeHighLevel(contents, shape, minSize, maxSize, hasForceC40Hint);
    }

    SymbolInfo symbolInfo = SymbolInfo.lookup(encoded.length(), shape, minSize, maxSize, true);

    //2. step: ECC generation
    String codewords = ErrorCorrection.encodeECC200(encoded, symbolInfo);

    //3. step: Module placement in Matrix
    DefaultPlacement placement =
        new DefaultPlacement(codewords, symbolInfo.getSymbolDataWidth(), symbolInfo.getSymbolDataHeight());
    placement.place();

    //4. step: low-level encoding
    return encodeLowLevel(placement, symbolInfo, width, height);
  }