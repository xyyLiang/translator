  public static int determineConsecutiveDigitCount(CharSequence msg, int startpos) {
    int len = msg.length();
    int idx = startpos;
    while (idx < len && isDigit(msg.charAt(idx))) {
      idx++;
    }
    return idx - startpos;
  }