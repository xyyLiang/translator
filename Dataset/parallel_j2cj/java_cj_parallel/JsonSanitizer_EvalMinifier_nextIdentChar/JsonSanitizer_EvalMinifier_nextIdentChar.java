  static int nextIdentChar(char ch, boolean allowDigits) {
    if (ch == 'z') { return 'A'; }
    if (ch == 'Z') { return '_'; }
    if (ch == '_') { return '$'; }
    if (ch == '$') {
      if (allowDigits) { return '0'; }
      return -1;
    }
    if (ch == '9') { return -1; }
    return (char) (ch + 1);
  }