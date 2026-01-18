  static int findMSBSet(int value) {
    return 32 - Integer.numberOfLeadingZeros(value);
  }