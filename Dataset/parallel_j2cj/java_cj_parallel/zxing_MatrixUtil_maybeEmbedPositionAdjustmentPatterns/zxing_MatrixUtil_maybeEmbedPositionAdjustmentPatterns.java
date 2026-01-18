  private static void maybeEmbedPositionAdjustmentPatterns(Version version, ByteMatrix matrix) {
    if (version.getVersionNumber() < 2) {  // The patterns appear if version >= 2
      return;
    }
    int index = version.getVersionNumber() - 1;
    int[] coordinates = POSITION_ADJUSTMENT_PATTERN_COORDINATE_TABLE[index];
    for (int y : coordinates) {
      if (y >= 0) {
        for (int x : coordinates) {
          if (x >= 0 && isEmpty(matrix.get(x, y))) {
            // If the cell is unset, we embed the position adjustment pattern here.
            // -2 is necessary since the x/y coordinates point to the center of the pattern, not the
            // left top corner.
            embedPositionAdjustmentPattern(x - 2, y - 2, matrix);
          }
        }
      }
    }
  }
