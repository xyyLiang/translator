  static void append8BitBytes(String content, BitArray bits, Charset encoding) {
    byte[] bytes = content.getBytes(encoding);
    for (byte b : bytes) {
      bits.appendBits(b, 8);
    }
  }
