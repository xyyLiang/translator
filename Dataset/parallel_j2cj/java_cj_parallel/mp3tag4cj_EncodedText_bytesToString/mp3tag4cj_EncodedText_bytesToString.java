 private static String bytesToString(byte[] bytes, String characterSet) throws CharacterCodingException {
  CharBuffer cbuf = bytesToCharBuffer(bytes, characterSet);
  String s = cbuf.toString();
  int length = s.indexOf(0);
  if (length == -1) return s;
  return s.substring(0, length);
 }