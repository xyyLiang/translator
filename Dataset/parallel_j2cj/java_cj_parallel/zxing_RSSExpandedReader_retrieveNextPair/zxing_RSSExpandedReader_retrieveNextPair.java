  ExpandedPair retrieveNextPair(BitArray row, List<ExpandedPair> previousPairs, int rowNumber)
      throws NotFoundException {
    boolean isOddPattern  = previousPairs.size() % 2 == 0;
    if (startFromEven) {
      isOddPattern = !isOddPattern;
    }

    FinderPattern pattern;
    DataCharacter leftChar = null;

    boolean keepFinding = true;
    int forcedOffset = -1;
    do {
      this.findNextPair(row, previousPairs, forcedOffset);
      pattern = parseFoundFinderPattern(row, rowNumber, isOddPattern, previousPairs);
      if (pattern == null) {
        forcedOffset = getNextSecondBar(row, this.startEnd[0]); // probable false positive, keep looking
      } else {
        try {
          leftChar  = this.decodeDataCharacter(row, pattern, isOddPattern, true);
          keepFinding = false;
        } catch (NotFoundException ignored) {
          forcedOffset = getNextSecondBar(row, this.startEnd[0]); // probable false positive, keep looking
        }
      }
    } while (keepFinding);

    // When stacked symbol is split over multiple rows, there's no way to guess if this pair can be last or not.
    // boolean mayBeLast = checkPairSequence(previousPairs, pattern);

    if (!previousPairs.isEmpty() && previousPairs.get(previousPairs.size() - 1).mustBeLast()) {
      throw NotFoundException.getNotFoundInstance();
    }

    DataCharacter rightChar;
    try {
      rightChar = this.decodeDataCharacter(row, pattern, isOddPattern, false);
    } catch (NotFoundException ignored) {
      rightChar = null;
    }
    return new ExpandedPair(leftChar, rightChar, pattern);
  }
