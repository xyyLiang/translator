  private FinderPattern parseFoundFinderPattern(BitArray row,
                                                int rowNumber,
                                                boolean oddPattern,
                                                List<ExpandedPair> previousPairs) {
    // Actually we found elements 2-5.
    int firstCounter;
    int start;
    int end;

    if (oddPattern) {
      // If pattern number is odd, we need to locate element 1 *before* the current block.

      int firstElementStart = this.startEnd[0] - 1;
      // Locate element 1
      while (firstElementStart >= 0 && !row.get(firstElementStart)) {
        firstElementStart--;
      }

      firstElementStart++;
      firstCounter = this.startEnd[0] - firstElementStart;
      start = firstElementStart;
      end = this.startEnd[1];

    } else {
      // If pattern number is even, the pattern is reversed, so we need to locate element 1 *after* the current block.

      start = this.startEnd[0];

      end = row.getNextUnset(this.startEnd[1] + 1);
      firstCounter = end - this.startEnd[1];
    }

    // Make 'counters' hold 1-4
    int [] counters = this.getDecodeFinderCounters();
    System.arraycopy(counters, 0, counters, 1, counters.length - 1);

    counters[0] = firstCounter;
    int value;
    try {
      value = parseFinderValue(counters, FINDER_PATTERNS);
    } catch (NotFoundException ignored) {
      return null;
    }

    // Check that the pattern type that we *think* we found can exist as part of a valid sequence of finder patterns.
    if (!mayFollow(previousPairs, value)) {
      return null;
    }

    // Check that the finder pattern that we *think* we found is not too far from where we would expect to find it,
    // given that finder patterns are 15 modules wide and the data characters between them are 17 modules wide.
    if (!previousPairs.isEmpty()) {
      ExpandedPair prev = previousPairs.get(previousPairs.size() - 1);
      int prevStart = prev.getFinderPattern().getStartEnd()[0];
      int prevEnd = prev.getFinderPattern().getStartEnd()[1];
      int prevWidth = prevEnd - prevStart;
      float charWidth = (prevWidth / FINDER_PATTERN_MODULES) * DATA_CHARACTER_MODULES;
      float minX = prevEnd + (2 * charWidth * (1 - MAX_FINDER_PATTERN_DISTANCE_VARIANCE));
      float maxX = prevEnd + (2 * charWidth * (1 + MAX_FINDER_PATTERN_DISTANCE_VARIANCE));
      if (start < minX || start > maxX) {
        return null;
      }
    }

    return new FinderPattern(value, new int[] {start, end}, start, end, rowNumber);
  }
