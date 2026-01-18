  private static int getInt(byte[] bytes, byte[] x) {
    int val = 0;
    for (int i = 0; i < x.length; i++) {
      val += getBit(x[i], bytes) << (x.length - i - 1);
    }
    return val;
  }