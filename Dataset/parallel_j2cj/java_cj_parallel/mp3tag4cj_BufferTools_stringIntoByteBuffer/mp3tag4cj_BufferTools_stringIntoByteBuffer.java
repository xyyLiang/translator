 public static void stringIntoByteBuffer(String s, int offset, int length, byte[] bytes, int destOffset) throws UnsupportedEncodingException {
  stringIntoByteBuffer(s, offset, length, bytes, destOffset, defaultCharsetName);
 }