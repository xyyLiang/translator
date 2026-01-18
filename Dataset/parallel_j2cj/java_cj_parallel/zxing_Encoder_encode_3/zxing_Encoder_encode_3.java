  public static AztecCode encode(byte[] data, int minECCPercent, int userSpecifiedLayers, Charset charset) {
    // High-level encode
    BitArray bits = new HighLevelEncoder(data, charset).encode();

    // stuff bits and choose symbol size
    int eccBits = bits.getSize() * minECCPercent / 100 + 11;
    int totalSizeBits = bits.getSize() + eccBits;
    boolean compact;
    int layers;
    int totalBitsInLayer;
    int wordSize;
    BitArray stuffedBits;
    if (userSpecifiedLayers != DEFAULT_AZTEC_LAYERS) {
      compact = userSpecifiedLayers < 0;
      layers = Math.abs(userSpecifiedLayers);
      if (layers > (compact ? MAX_NB_BITS_COMPACT : MAX_NB_BITS)) {
        throw new IllegalArgumentException(
            String.format("Illegal value %s for layers", userSpecifiedLayers));
      }
      totalBitsInLayer = totalBitsInLayer(layers, compact);
      wordSize = WORD_SIZE[layers];
      int usableBitsInLayers = totalBitsInLayer - (totalBitsInLayer % wordSize);
      stuffedBits = stuffBits(bits, wordSize);
      if (stuffedBits.getSize() + eccBits > usableBitsInLayers) {
        throw new IllegalArgumentException("Data to large for user specified layer");
      }
      if (compact && stuffedBits.getSize() > wordSize * 64) {
        // Compact format only allows 64 data words, though C4 can hold more words than that
        throw new IllegalArgumentException("Data to large for user specified layer");
      }
    } else {
      wordSize = 0;
      stuffedBits = null;
      // We look at the possible table sizes in the order Compact1, Compact2, Compact3,
      // Compact4, Normal4,...  Normal(i) for i < 4 isn't typically used since Compact(i+1)
      // is the same size, but has more data.
      for (int i = 0; ; i++) {
        if (i > MAX_NB_BITS) {
          throw new IllegalArgumentException("Data too large for an Aztec code");
        }
        compact = i <= 3;
        layers = compact ? i + 1 : i;
        totalBitsInLayer = totalBitsInLayer(layers, compact);
        if (totalSizeBits > totalBitsInLayer) {
          continue;
        }
        // [Re]stuff the bits if this is the first opportunity, or if the
        // wordSize has changed
        if (stuffedBits == null || wordSize != WORD_SIZE[layers]) {
          wordSize = WORD_SIZE[layers];
          stuffedBits = stuffBits(bits, wordSize);
        }
        int usableBitsInLayers = totalBitsInLayer - (totalBitsInLayer % wordSize);
        if (compact && stuffedBits.getSize() > wordSize * 64) {
          // Compact format only allows 64 data words, though C4 can hold more words than that
          continue;
        }
        if (stuffedBits.getSize() + eccBits <= usableBitsInLayers) {
          break;
        }
      }
    }
    BitArray messageBits = generateCheckWords(stuffedBits, totalBitsInLayer, wordSize);

    // generate mode message
    int messageSizeInWords = stuffedBits.getSize() / wordSize;
    BitArray modeMessage = generateModeMessage(compact, layers, messageSizeInWords);

    // allocate symbol
    int baseMatrixSize = (compact ? 11 : 14) + layers * 4; // not including alignment lines
    int[] alignmentMap = new int[baseMatrixSize];
    int matrixSize;
    if (compact) {
      // no alignment marks in compact mode, alignmentMap is a no-op
      matrixSize = baseMatrixSize;
      for (int i = 0; i < alignmentMap.length; i++) {
        alignmentMap[i] = i;
      }
    } else {
      matrixSize = baseMatrixSize + 1 + 2 * ((baseMatrixSize / 2 - 1) / 15);
      int origCenter = baseMatrixSize / 2;
      int center = matrixSize / 2;
      for (int i = 0; i < origCenter; i++) {
        int newOffset = i + i / 15;
        alignmentMap[origCenter - i - 1] = center - newOffset - 1;
        alignmentMap[origCenter + i] = center + newOffset + 1;
      }
    }
    BitMatrix matrix = new BitMatrix(matrixSize);

    // draw data bits
    for (int i = 0, rowOffset = 0; i < layers; i++) {
      int rowSize = (layers - i) * 4 + (compact ? 9 : 12);
      for (int j = 0; j < rowSize; j++) {
        int columnOffset = j * 2;
        for (int k = 0; k < 2; k++) {
          if (messageBits.get(rowOffset + columnOffset + k)) {
            matrix.set(alignmentMap[i * 2 + k], alignmentMap[i * 2 + j]);
          }
          if (messageBits.get(rowOffset + rowSize * 2 + columnOffset + k)) {
            matrix.set(alignmentMap[i * 2 + j], alignmentMap[baseMatrixSize - 1 - i * 2 - k]);
          }
          if (messageBits.get(rowOffset + rowSize * 4 + columnOffset + k)) {
            matrix.set(alignmentMap[baseMatrixSize - 1 - i * 2 - k], alignmentMap[baseMatrixSize - 1 - i * 2 - j]);
          }
          if (messageBits.get(rowOffset + rowSize * 6 + columnOffset + k)) {
            matrix.set(alignmentMap[baseMatrixSize - 1 - i * 2 - j], alignmentMap[i * 2 + k]);
          }
        }
      }
      rowOffset += rowSize * 8;
    }

    // draw mode message
    drawModeMessage(matrix, compact, matrixSize, modeMessage);

    // draw alignment marks
    if (compact) {
      drawBullsEye(matrix, matrixSize / 2, 5);
    } else {
      drawBullsEye(matrix, matrixSize / 2, 7);
      for (int i = 0, j = 0; i < baseMatrixSize / 2 - 1; i += 15, j += 16) {
        for (int k = (matrixSize / 2) & 1; k < matrixSize; k += 2) {
          matrix.set(matrixSize / 2 - j, k);
          matrix.set(matrixSize / 2 + j, k);
          matrix.set(k, matrixSize / 2 - j);
          matrix.set(k, matrixSize / 2 + j);
        }
      }
    }

    AztecCode aztec = new AztecCode();
    aztec.setCompact(compact);
    aztec.setSize(matrixSize);
    aztec.setLayers(layers);
    aztec.setCodeWords(messageSizeInWords);
    aztec.setMatrix(matrix);
    return aztec;
  }
