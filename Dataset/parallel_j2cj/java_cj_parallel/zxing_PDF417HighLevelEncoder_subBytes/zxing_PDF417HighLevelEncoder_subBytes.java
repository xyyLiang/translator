  static byte[] subBytes(ECIInput input, int start, int end) {
    final int count = end - start;
    byte[] result = new byte[count];
    for (int i = start; i < end; i++) {
      result[i - start] = (byte) (input.charAt(i) & 0xff);
    }
    return result;
  }