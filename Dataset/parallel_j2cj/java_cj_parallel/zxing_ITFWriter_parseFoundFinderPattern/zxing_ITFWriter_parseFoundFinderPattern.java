  private FinderPattern parseFoundFinderPattern(BitArray row, int rowNumber, boolean right, int[] startEnd)
      throws NotFoundException {
    // Actually we found elements 2-5
    boolean firstIsBlack = row.get(startEnd[0]);
    int firstElementStart = startEnd[0] - 1;
    // Locate element 1
    while (firstElementStart >= 0 && firstIsBlack != row.get(firstElementStart)) {
      firstElementStart--;
    }
    firstElementStart++;
    int firstCounter = startEnd[0] - firstElementStart;
    // Make 'counters' hold 1-4
    int[] counters = getDecodeFinderCounters();
    System.arraycopy(counters, 0, counters, 1, counters.length - 1);
    counters[0] = firstCounter;
    int value = parseFinderValue(counters, FINDER_PATTERNS);
    int start = firstElementStart;
    int end = startEnd[1];
    if (right) {
      // row is actually reversed
      start = row.getSize() - 1 - start;
      end = row.getSize() - 1 - end;
    }
    return new FinderPattern(value, new int[] {firstElementStart, startEnd[1]}, start, end, rowNumber);
  }
