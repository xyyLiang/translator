  private static boolean checkChecksum(Pair leftPair, Pair rightPair) {
    int checkValue = (leftPair.getChecksumPortion() + 16 * rightPair.getChecksumPortion()) % 79;
    int targetCheckValue =
        9 * leftPair.getFinderPattern().getValue() + rightPair.getFinderPattern().getValue();
    if (targetCheckValue > 72) {
      targetCheckValue--;
    }
    if (targetCheckValue > 8) {
      targetCheckValue--;
    }
    return checkValue == targetCheckValue;
  }
