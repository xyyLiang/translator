  private boolean isJsonSpecialChar(int i) {
    char ch = jsonish.charAt(i);
    if (ch <= ' ') { return true; }
    switch (ch) {
      case '"':
      case ',': case ':':
      case '[': case ']':
      case '{': case '}':
        return true;
      default:
        return false;
    }
  }