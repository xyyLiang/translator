  String lookupCountryIdentifier(String productCode) {
    initIfNeeded();
    int prefix = Integer.parseInt(productCode.substring(0, 3));
    int max = ranges.size();
    for (int i = 0; i < max; i++) {
      int[] range = ranges.get(i);
      int start = range[0];
      if (prefix < start) {
        return null;
      }
      int end = range.length == 1 ? start : range[1];
      if (prefix <= end) {
        return countryIdentifiers.get(i);
      }
    }
    return null;
  }