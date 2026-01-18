 private static byte[] stringToBytes(String s, String characterSet) {
  try {
   return charBufferToBytes(CharBuffer.wrap(s), characterSet);
  } catch (CharacterCodingException e) {
   return null;
  }
 }