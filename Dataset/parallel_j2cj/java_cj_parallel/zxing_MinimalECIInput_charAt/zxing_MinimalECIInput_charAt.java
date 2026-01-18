  public char charAt(int index) {
    if (index < 0 || index >= length()) {
      throw new IndexOutOfBoundsException("" + index);
    }
    if (isECI(index)) {
      throw new IllegalArgumentException("value at " + index + " is not a character but an ECI");
    }
    return isFNC1(index) ? (char) fnc1 : (char) bytes[index];
  }