 public static byte[] stringToByteBuffer(String s, int offset, int length, String charsetName) throws UnsupportedEncodingException {
  String stringToCopy = s.substring(offset, offset + length);
  return stringToCopy.getBytes(charsetName);
 }