  protected static boolean isFinderPattern(int[] counters) {
    int firstTwoSum = counters[0] + counters[1];
    int sum = firstTwoSum + counters[2] + counters[3];
    float ratio = firstTwoSum / (float) sum;
    if (ratio >= MIN_FINDER_PATTERN_RATIO && ratio <= MAX_FINDER_PATTERN_RATIO) {
      // passes ratio test in spec, but see if the counts are unreasonable
      int minCounter = Integer.MAX_VALUE;
      int maxCounter = Integer.MIN_VALUE;
      for (int counter : counters) {
        if (counter > maxCounter) {
          maxCounter = counter;
        }
        if (counter < minCounter) {
          minCounter = counter;
        }
      }
      return maxCounter < 10 * minCounter;
    }
    return false;
  }