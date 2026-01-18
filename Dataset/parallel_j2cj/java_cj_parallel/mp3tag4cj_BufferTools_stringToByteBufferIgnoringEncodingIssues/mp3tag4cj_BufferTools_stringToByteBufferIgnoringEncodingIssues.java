 public static byte[] stringToByteBufferIgnoringEncodingIssues(String s, int offset, int length) {
  try {
   return stringToByteBuffer(s, offset, length);
  } catch (UnsupportedEncodingException e) {
   return null;
  }
 }