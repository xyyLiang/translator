 public static void stringIntoByteBuffer(String s, int offset, int length, byte[] bytes, int destOffset, String charsetName) throws UnsupportedEncodingException {
  String stringToCopy = s.substring(offset, offset + length);
  byte[] srcBytes = stringToCopy.getBytes(charsetName);
  if (srcBytes.length > 0) {
   System.arraycopy(srcBytes, 0, bytes, destOffset, srcBytes.length);
  }
 }