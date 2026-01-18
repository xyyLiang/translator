 public static String byteBufferToString(byte[] bytes, int offset, int length) throws UnsupportedEncodingException {
  return byteBufferToString(bytes, offset, length, defaultCharsetName);
 }