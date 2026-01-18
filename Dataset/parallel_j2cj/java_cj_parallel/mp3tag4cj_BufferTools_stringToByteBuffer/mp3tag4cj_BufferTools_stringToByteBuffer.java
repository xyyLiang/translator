 public static byte[] stringToByteBuffer(String s, int offset, int length) throws UnsupportedEncodingException {
  return stringToByteBuffer(s, offset, length, defaultCharsetName);
 }