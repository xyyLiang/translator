  private static boolean isLetterOrNumberChar(char ch) {
    if ('0' <= ch && ch <= '9') { return true; }
    char lch = (char) (ch | 32);
    if ('a' <= lch && lch <= 'z') { return true; }
    return ch == '_' || ch == '$' || ch == '-' || ch == '.';
  }