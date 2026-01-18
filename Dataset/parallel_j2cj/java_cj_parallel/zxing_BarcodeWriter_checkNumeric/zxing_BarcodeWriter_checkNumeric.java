  protected static void checkNumeric(String contents) {
    if (!NUMERIC.matcher(contents).matches()) {
      throw new IllegalArgumentException("Input should only contain digits 0-9");
    }
  }