  private DataCharacter decodeDataCharacter(BitArray row, FinderPattern pattern, boolean outsideChar)
      throws NotFoundException {

    int[] counters = getDataCharacterCounters();
    Arrays.fill(counters, 0);

    if (outsideChar) {
      recordPatternInReverse(row, pattern.getStartEnd()[0], counters);
    } else {
      recordPattern(row, pattern.getStartEnd()[1], counters);
      // reverse it
      for (int i = 0, j = counters.length - 1; i < j; i++, j--) {
        int temp = counters[i];
        counters[i] = counters[j];
        counters[j] = temp;
      }
    }

    int numModules = outsideChar ? 16 : 15;
    float elementWidth = MathUtils.sum(counters) / (float) numModules;

    int[] oddCounts = this.getOddCounts();
    int[] evenCounts = this.getEvenCounts();
    float[] oddRoundingErrors = this.getOddRoundingErrors();
    float[] evenRoundingErrors = this.getEvenRoundingErrors();

    for (int i = 0; i < counters.length; i++) {
      float value = counters[i] / elementWidth;
      int count = (int) (value + 0.5f); // Round
      if (count < 1) {
        count = 1;
      } else if (count > 8) {
        count = 8;
      }
      int offset = i / 2;
      if ((i & 0x01) == 0) {
        oddCounts[offset] = count;
        oddRoundingErrors[offset] = value - count;
      } else {
        evenCounts[offset] = count;
        evenRoundingErrors[offset] = value - count;
      }
    }

    adjustOddEvenCounts(outsideChar, numModules);

    int oddSum = 0;
    int oddChecksumPortion = 0;
    for (int i = oddCounts.length - 1; i >= 0; i--) {
      oddChecksumPortion *= 9;
      oddChecksumPortion += oddCounts[i];
      oddSum += oddCounts[i];
    }
    int evenChecksumPortion = 0;
    int evenSum = 0;
    for (int i = evenCounts.length - 1; i >= 0; i--) {
      evenChecksumPortion *= 9;
      evenChecksumPortion += evenCounts[i];
      evenSum += evenCounts[i];
    }
    int checksumPortion = oddChecksumPortion + 3 * evenChecksumPortion;

    if (outsideChar) {
      if ((oddSum & 0x01) != 0 || oddSum > 12 || oddSum < 4) {
        throw NotFoundException.getNotFoundInstance();
      }
      int group = (12 - oddSum) / 2;
      int oddWidest = OUTSIDE_ODD_WIDEST[group];
      int evenWidest = 9 - oddWidest;
      int vOdd = RSSUtils.getRSSvalue(oddCounts, oddWidest, false);
      int vEven = RSSUtils.getRSSvalue(evenCounts, evenWidest, true);
      int tEven = OUTSIDE_EVEN_TOTAL_SUBSET[group];
      int gSum = OUTSIDE_GSUM[group];
      return new DataCharacter(vOdd * tEven + vEven + gSum, checksumPortion);
    } else {
      if ((evenSum & 0x01) != 0 || evenSum > 10 || evenSum < 4) {
        throw NotFoundException.getNotFoundInstance();
      }
      int group = (10 - evenSum) / 2;
      int oddWidest = INSIDE_ODD_WIDEST[group];
      int evenWidest = 9 - oddWidest;
      int vOdd = RSSUtils.getRSSvalue(oddCounts, oddWidest, true);
      int vEven = RSSUtils.getRSSvalue(evenCounts, evenWidest, false);
      int tOdd = INSIDE_ODD_TOTAL_SUBSET[group];
      int gSum = INSIDE_GSUM[group];
      return new DataCharacter(vEven * tOdd + vOdd + gSum, checksumPortion);
    }

  }
