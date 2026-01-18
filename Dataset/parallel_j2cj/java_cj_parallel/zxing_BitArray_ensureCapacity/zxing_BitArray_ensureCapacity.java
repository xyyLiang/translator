  private void ensureCapacity(int newSize) {
    if (newSize > bits.length * 32) {
      int[] newBits = makeArray((int) Math.ceil(newSize / LOAD_FACTOR));
      System.arraycopy(bits, 0, newBits, 0, bits.length);
      this.bits = newBits;
    }
  }