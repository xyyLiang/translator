  private static int[] findGuardPattern(BitMatrix matrix,
                                        int column,
                                        int row,
                                        int width,
                                        int[] pattern,
                                        int[] counters) {
    Arrays.fill(counters, 0, counters.length, 0);
    int patternStart = column;
    int pixelDrift = 0;

    // if there are black pixels left of the current pixel shift to the left, but only for MAX_PIXEL_DRIFT pixels
    while (matrix.get(patternStart, row) && patternStart > 0 && pixelDrift++ < MAX_PIXEL_DRIFT) {
      patternStart--;
    }
    int x = patternStart;
    int counterPosition = 0;
    int patternLength = pattern.length;
    for (boolean isWhite = false; x < width; x++) {
      boolean pixel = matrix.get(x, row);
      if (pixel != isWhite) {
        counters[counterPosition]++;
      } else {
        if (counterPosition == patternLength - 1) {
          if (patternMatchVariance(counters, pattern) < MAX_AVG_VARIANCE) {
            return new int[] {patternStart, x};
          }
          patternStart += counters[0] + counters[1];
          System.arraycopy(counters, 2, counters, 0, counterPosition - 1);
          counters[counterPosition - 1] = 0;
          counters[counterPosition] = 0;
          counterPosition--;
        } else {
          counterPosition++;
        }
        counters[counterPosition] = 1;
        isWhite = !isWhite;
      }
    }
    if (counterPosition == patternLength - 1 &&
        patternMatchVariance(counters, pattern) < MAX_AVG_VARIANCE) {
      return new int[] {patternStart, x - 1};
    }
    return null;
  }
