  protected static int parseFinderValue(int[] counters,
                                        int[][] finderPatterns) throws NotFoundException {
    for (int value = 0; value < finderPatterns.length; value++) {
      if (patternMatchVariance(counters, finderPatterns[value], MAX_INDIVIDUAL_VARIANCE) <
          MAX_AVG_VARIANCE) {
        return value;
      }
    }
    throw NotFoundException.getNotFoundInstance();
  }
