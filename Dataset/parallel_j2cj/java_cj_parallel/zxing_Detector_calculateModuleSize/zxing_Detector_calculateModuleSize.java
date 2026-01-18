  protected final float calculateModuleSize(ResultPoint topLeft,
                                            ResultPoint topRight,
                                            ResultPoint bottomLeft) {
    // Take the average
    return (calculateModuleSizeOneWay(topLeft, topRight) +
        calculateModuleSizeOneWay(topLeft, bottomLeft)) / 2.0f;
  }
