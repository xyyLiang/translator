  private boolean foundPatternCross(int[] stateCount) {
    float moduleSize = this.moduleSize;
    float maxVariance = moduleSize / 2.0f;
    for (int i = 0; i < 3; i++) {
      if (Math.abs(moduleSize - stateCount[i]) >= maxVariance) {
        return false;
      }
    }
    