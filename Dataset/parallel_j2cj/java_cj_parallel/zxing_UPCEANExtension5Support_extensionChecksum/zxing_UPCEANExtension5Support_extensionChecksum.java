  private static int extensionChecksum(CharSequence s) {
    int length = s.length();
    int sum = 0;
    for (int i = length - 2; i >= 0; i -= 2) {
      sum += s.charAt(i) - '0';
    }
    sum *= 3;
    for (int i = length - 1; i >= 0; i -= 2) {
      sum += s.charAt(i) - '0';
    }
    sum *= 3;
    return sum % 10;
  }
