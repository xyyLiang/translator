  private static void appendCheckDigit(StringBuilder buf, int currentPos) {
    int checkDigit = 0;
    for (int i = 0; i < 13; i++) {
      int digit = buf.charAt(i + currentPos) - '0';
      checkDigit += (i & 0x01) == 0 ? 3 * digit : digit;
    }

    checkDigit = 10 - (checkDigit % 10);
    if (checkDigit == 10) {
      checkDigit = 0;
    }

    buf.append(checkDigit);
  }