 private void packField(byte[] bytes, String value, int maxLength, int offset) {
  if (value != null) {
   try {
    BufferTools.stringIntoByteBuffer(value, 0, Math.min(value.length(), maxLength), bytes, offset);
   } catch (UnsupportedEncodingException e) {
   }
  }
 }