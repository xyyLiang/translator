  private static int computeChecksumIndex(String contents, int maxWeight) {
    int weight = 1;
    int total = 0;

    for (int i = contents.length() - 1; i >= 0; i--) {
      int indexInString = Code93Reader.ALPHABET_STRING.indexOf(contents.charAt(i));
      total += indexInString * weight;
      if (++weight > maxWeight) {
        weight = 1;
      }
    }
    return total % 47;
  }