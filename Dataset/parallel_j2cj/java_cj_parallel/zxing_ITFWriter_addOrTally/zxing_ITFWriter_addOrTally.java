  private static void addOrTally(Collection<Pair> possiblePairs, Pair pair) {
    if (pair == null) {
      return;
    }
    boolean found = false;
    for (Pair other : possiblePairs) {
      if (other.getValue() == pair.getValue()) {
        other.incrementCount();
        found = true;
        break;
      }
    }
    if (!found) {
      possiblePairs.add(pair);
    }
  }