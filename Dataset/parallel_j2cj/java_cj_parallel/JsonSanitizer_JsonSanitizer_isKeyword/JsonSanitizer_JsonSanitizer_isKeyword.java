
  private boolean isKeyword(int start, int end) {
    int n = end - start;
    if (n == 5) {
      return "false".regionMatches(0, jsonish, start, n);
    } else if (n == 4) {
      return "null".regionMatches(0, jsonish, start, n)
          || "true".regionMatches(0, jsonish, start, n);
    }
    return false;
  }