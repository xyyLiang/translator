  private int copyBit(int i, int j, int versionBits) {
    boolean bit = mirror ? bitMatrix.get(j, i) : bitMatrix.get(i, j);
    return bit ? (versionBits << 1) | 0x1 : versionBits << 1;
  }