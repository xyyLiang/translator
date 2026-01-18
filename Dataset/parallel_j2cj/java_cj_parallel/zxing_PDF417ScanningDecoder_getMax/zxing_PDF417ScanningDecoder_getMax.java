  private static int getMax(int[] values) {
    int maxValue = -1;
    for (int value : values) {
      maxValue = Math.max(maxValue, value);
    }
    return maxValue;
  }
