  private int extractParameters(ResultPoint[] bullsEyeCorners) throws NotFoundException {
    if (!isValid(bullsEyeCorners[0]) || !isValid(bullsEyeCorners[1]) ||
        !isValid(bullsEyeCorners[2]) || !isValid(bullsEyeCorners[3])) {
      throw NotFoundException.getNotFoundInstance();
    }
    int length = 2 * nbCenterLayers;
    // Get the bits around the bull's eye
    int[] sides = {
        sampleLine(bullsEyeCorners[0], bullsEyeCorners[1], length), // Right side
        sampleLine(bullsEyeCorners[1], bullsEyeCorners[2], length), // Bottom
        sampleLine(bullsEyeCorners[2], bullsEyeCorners[3], length), // Left side
        sampleLine(bullsEyeCorners[3], bullsEyeCorners[0], length)  // Top
    };

    // bullsEyeCorners[shift] is the corner of the bulls'eye that has three
    // orientation marks.
    // sides[shift] is the row/column that goes from the corner with three
    // orientation marks to the corner with two.
    shift = getRotation(sides, length);

    // Flatten the parameter bits into a single 28- or 40-bit long
    long parameterData = 0;
    for (int i = 0; i < 4; i++) {
      int side = sides[(shift + i) % 4];
      if (compact) {
        // Each side of the form ..XXXXXXX. where Xs are parameter data
        parameterData <<= 7;
        parameterData += (side >> 1) & 0x7F;
      } else {
        // Each side of the form ..XXXXX.XXXXX. where Xs are parameter data
        parameterData <<= 10;
        parameterData += ((side >> 2) & (0x1f << 5)) + ((side >> 1) & 0x1F);
      }
    }

    // Corrects parameter data using RS.  Returns just the data portion
    // without the error correction.
    CorrectedParameter correctedParam = getCorrectedParameterData(parameterData, compact);
    int correctedData = correctedParam.getData();

    if (compact) {
      // 8 bits:  2 bits layers and 6 bits data blocks
      nbLayers = (correctedData >> 6) + 1;
      nbDataBlocks = (correctedData & 0x3F) + 1;
    } else {
      // 16 bits:  5 bits layers and 11 bits data blocks
      nbLayers = (correctedData >> 11) + 1;
      nbDataBlocks = (correctedData & 0x7FF) + 1;
    }

    return correctedParam.getErrorsCorrected();
  }
