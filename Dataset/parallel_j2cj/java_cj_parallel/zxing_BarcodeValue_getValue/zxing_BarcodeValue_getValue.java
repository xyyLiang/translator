  int[] getValue() {
    int maxConfidence = -1;
    Collection<Integer> result = new ArrayList<>();
    for (Entry<Integer,Integer> entry : values.entrySet()) {
      if (entry.getValue() > maxConfidence) {
        maxConfidence = entry.getValue();
        result.clear();
        result.add(entry.getKey());
      } else if (entry.getValue() == maxConfidence) {
        result.add(entry.getKey());
      }
    }
    return PDF417Common.toIntArray(result);
  }
