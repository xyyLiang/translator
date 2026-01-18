  public static Version getProvisionalVersionForDimension(int dimension) throws FormatException {
    if (dimension % 4 != 1) {
      throw FormatException.getFormatInstance();
    }
    try {
      return getVersionForNumber((dimension - 17) / 4);
    } catch (IllegalArgumentException ignored) {
      throw FormatException.getFormatInstance();
    }
  }