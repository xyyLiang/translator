  public int available() {
    return 8 * (bytes.length - byteOffset) - bitOffset;
  }