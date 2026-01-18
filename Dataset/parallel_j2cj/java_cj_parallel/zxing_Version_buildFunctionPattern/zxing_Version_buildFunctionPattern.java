  BitMatrix buildFunctionPattern() {
    int dimension = getDimensionForVersion();
    BitMatrix bitMatrix = new BitMatrix(dimension);

    // Top left finder pattern + separator + format
    bitMatrix.setRegion(0, 0, 9, 9);
    // Top right finder pattern + separator + format
    bitMatrix.setRegion(dimension - 8, 0, 8, 9);
    // Bottom left finder pattern + separator + format
    bitMatrix.setRegion(0, dimension - 8, 9, 8);

    // Alignment patterns
    int max = alignmentPatternCenters.length;
    for (int x = 0; x < max; x++) {
      int i = alignmentPatternCenters[x] - 2;
      for (int y = 0; y < max; y++) {
        if ((x != 0 || (y != 0 && y != max - 1)) && (x != max - 1 || y != 0)) {
          bitMatrix.setRegion(alignmentPatternCenters[y] - 2, i, 5, 5);
        }
        // else no o alignment patterns near the three finder patterns
      }
    }

    // Vertical timing pattern
    bitMatrix.setRegion(6, 9, 1, dimension - 17);
    // Horizontal timing pattern
    bitMatrix.setRegion(9, 6, dimension - 17, 1);

    if (versionNumber > 6) {
      // Version info, top right
      bitMatrix.setRegion(dimension - 11, 0, 3, 6);
      // Version info, bottom left
      bitMatrix.setRegion(0, dimension - 11, 6, 3);
    }

    return bitMatrix;
  }
