  public void flip() {
    int max = bits.length;
    for (int i = 0; i < max; i++) {
      bits[i] = ~bits[i];
    }
  }