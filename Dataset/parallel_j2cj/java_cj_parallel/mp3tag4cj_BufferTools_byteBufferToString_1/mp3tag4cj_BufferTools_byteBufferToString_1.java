 public static String byteBufferToString(byte[] bytes, int offset, int length, String charsetName) throws UnsupportedEncodingException {
  if (length < 1) return "";
  return new String(bytes, offset, length, charsetName);
 }