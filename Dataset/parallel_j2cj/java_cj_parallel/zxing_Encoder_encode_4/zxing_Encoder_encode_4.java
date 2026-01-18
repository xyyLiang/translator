  public static QRCode encode(String content,
                              ErrorCorrectionLevel ecLevel,
                              Map<EncodeHintType,?> hints) throws WriterException {

    Version version;
    BitArray headerAndDataBits;
    Mode mode;

    boolean hasGS1FormatHint = hints != null && hints.containsKey(EncodeHintType.GS1_FORMAT) &&
        Boolean.parseBoolean(hints.get(EncodeHintType.GS1_FORMAT).toString());
    boolean hasCompactionHint = hints != null && hints.containsKey(EncodeHintType.QR_COMPACT) &&
        Boolean.parseBoolean(hints.get(EncodeHintType.QR_COMPACT).toString());

    // Determine what character encoding has been specified by the caller, if any
    Charset encoding = DEFAULT_BYTE_MODE_ENCODING;
    boolean hasEncodingHint = hints != null && hints.containsKey(EncodeHintType.CHARACTER_SET);
    if (hasEncodingHint) {
      try {
        encoding = Charset.forName(hints.get(EncodeHintType.CHARACTER_SET).toString());
      } catch (UnsupportedCharsetException ignore) {
        //ignore the encodingHint and use the DEFAULT_BYTE_MODE_ENCODING
      }
    }

    if (hasCompactionHint) {
      mode = Mode.BYTE;

      Charset priorityEncoding = encoding.equals(DEFAULT_BYTE_MODE_ENCODING) ? null : encoding;
      MinimalEncoder.ResultList rn = MinimalEncoder.encode(content, null, priorityEncoding, hasGS1FormatHint, ecLevel);

      headerAndDataBits = new BitArray();
      rn.getBits(headerAndDataBits);
      version = rn.getVersion();

    } else {

      // Pick an encoding mode appropriate for the content. Note that this will not attempt to use
      // multiple modes / segments even if that were more efficient.
      mode = chooseMode(content, encoding);

      // This will store the header information, like mode and
      // length, as well as "header" segments like an ECI segment.
      BitArray headerBits = new BitArray();

      // Append ECI segment if applicable
      if (mode == Mode.BYTE && hasEncodingHint) {
        CharacterSetECI eci = CharacterSetECI.getCharacterSetECI(encoding);
        if (eci != null) {
          appendECI(eci, headerBits);
        }
      }

      // Append the FNC1 mode header for GS1 formatted data if applicable
      if (hasGS1FormatHint) {
        // GS1 formatted codes are prefixed with a FNC1 in first position mode header
        appendModeInfo(Mode.FNC1_FIRST_POSITION, headerBits);
      }

      // (With ECI in place,) Write the mode marker
      appendModeInfo(mode, headerBits);

      // Collect data within the main segment, separately, to count its size if needed. Don't add it to
      // main payload yet.
      BitArray dataBits = new BitArray();
      appendBytes(content, mode, dataBits, encoding);

      if (hints != null && hints.containsKey(EncodeHintType.QR_VERSION)) {
        int versionNumber = Integer.parseInt(hints.get(EncodeHintType.QR_VERSION).toString());
        version = Version.getVersionForNumber(versionNumber);
        int bitsNeeded = calculateBitsNeeded(mode, headerBits, dataBits, version);
        if (!willFit(bitsNeeded, version, ecLevel)) {
          throw new WriterException("Data too big for requested version");
        }
      } else {
        version = recommendVersion(ecLevel, mode, headerBits, dataBits);
      }

      headerAndDataBits = new BitArray();
      headerAndDataBits.appendBitArray(headerBits);
      // Find "length" of main segment and write it
      int numLetters = mode == Mode.BYTE ? dataBits.getSizeInBytes() : content.length();
      appendLengthInfo(numLetters, version, mode, headerAndDataBits);
      // Put data together into the overall payload
      headerAndDataBits.appendBitArray(dataBits);
    }

    Version.ECBlocks ecBlocks = version.getECBlocksForLevel(ecLevel);
    int numDataBytes = version.getTotalCodewords() - ecBlocks.getTotalECCodewords();

    // Terminate the bits properly.
    terminateBits(numDataBytes, headerAndDataBits);

    // Interleave data bits with error correction code.
    BitArray finalBits = interleaveWithECBytes(headerAndDataBits,
                                               version.getTotalCodewords(),
                                               numDataBytes,
                                               ecBlocks.getNumBlocks());

    QRCode qrCode = new QRCode();

    qrCode.setECLevel(ecLevel);
    qrCode.setMode(mode);
    qrCode.setVersion(version);

    //  Choose the mask pattern and set to "qrCode".
    int dimension = version.getDimensionForVersion();
    ByteMatrix matrix = new ByteMatrix(dimension, dimension);

    // Enable manual selection of the pattern to be used via hint
    int maskPattern = -1;
    if (hints != null && hints.containsKey(EncodeHintType.QR_MASK_PATTERN)) {
      int hintMaskPattern = Integer.parseInt(hints.get(EncodeHintType.QR_MASK_PATTERN).toString());
      maskPattern = QRCode.isValidMaskPattern(hintMaskPattern) ? hintMaskPattern : -1;
    }

    if (maskPattern == -1) {
      maskPattern = chooseMaskPattern(finalBits, ecLevel, version, matrix);
    }
    qrCode.setMaskPattern(maskPattern);

    // Build the matrix and set it to "qrCode".
    MatrixUtil.buildMatrix(finalBits, ecLevel, version, maskPattern, matrix);
    qrCode.setMatrix(matrix);

    return qrCode;
  }
