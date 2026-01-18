  private static void determineFirstDigit(StringBuilder resultString, int lgPatternFound)
      throws NotFoundException {
    for (int d = 0; d < 10; d++) {
      if (lgPatternFound == FIRST_DIGIT_ENCODINGS[d]) {
        resultString.insert(0, (char) ('0' + d));
        return;
      }
    }
    throw NotFoundException.getNotFoundInstance();
  }