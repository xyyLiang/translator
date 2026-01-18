  private static char encodeASCIIDigits(char digit1, char digit2) {
    if (HighLevelEncoder.isDigit(digit1) && HighLevelEncoder.isDigit(digit2)) {
      int num = (digit1 - 48) * 10 + (digit2 - 48);
      return (char) (num + 130);
    }
    throw new IllegalArgumentException("not digits: " + digit1 + digit2);
  }