 public static String byteBufferToStringIgnoringEncodingIssues(byte[] bytes, int offset, int length) {
  try {
   return byteBufferToString(bytes, offset, length, defaultCharsetName);
  } catch (UnsupportedEncodingException e) {
   return null;
  }
 }