  private int endOfDigitRun(int start, int limit) {
    for (int end = start; end < limit; ++end) {
      char ch = jsonish.charAt(end);
      if (!('0' <= ch && ch <= '9')) { return end; }
    }
    return limit;
  }