  private static void checkChecksums(CharSequence result) throws ChecksumException {
    int length = result.length();
    checkOneChecksum(result, length - 2, 20);
    checkOneChecksum(result, length - 1, 15);
  }