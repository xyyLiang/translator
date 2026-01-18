  private static void determineNumSysAndCheckDigit(StringBuilder resultString, int lgPatternFound)
      throws NotFoundException {

    for (int numSys = 0; numSys <= 1; numSys++) {
      for (int d = 0; d < 10; d++) {
        if (lgPatternFound == NUMSYS_AND_CHECK_DIGIT_PATTERNS[numSys][d]) {
          resultString.insert(0, (char) ('0' + numSys));
          resultString.append((char) ('0' + d));
          return;
        }
      }
    }
    throw NotFoundException.getNotFoundInstance();
  }