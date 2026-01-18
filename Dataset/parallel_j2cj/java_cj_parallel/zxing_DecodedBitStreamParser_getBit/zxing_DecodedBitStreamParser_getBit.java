  private static int getBit(int bit, byte[] bytes) {
    bit--;
    return (bytes[bit / 6] & (1 << (5 - (bit % 6)))) == 0 ? 0 : 1;
  }