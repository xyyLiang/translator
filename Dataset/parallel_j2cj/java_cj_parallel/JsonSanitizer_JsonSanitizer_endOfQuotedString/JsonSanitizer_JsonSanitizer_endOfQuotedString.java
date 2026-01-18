  private static int endOfQuotedString(String s, int start) {
    char quote = s.charAt(start);
    for (int i = start; (i = s.indexOf(quote, i + 1)) >= 0;) {
      // If there are an even number of preceding backslashes then this is
      // the end of the string.
      int slashRunStart = i;
      while (slashRunStart > start && s.charAt(slashRunStart - 1) == '\\') {
        --slashRunStart;
      }
      if (((i - slashRunStart) & 1) == 0) {
        return i + 1;
      }
    }
    return s.length();
  }