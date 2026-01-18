 private void packHeader(byte[] bytes, int i) {
  try {
   BufferTools.stringIntoByteBuffer(id, 0, id.length(), bytes, 0);
  } catch (UnsupportedEncodingException e) {
  }
  BufferTools.copyIntoByteBuffer(packDataLength(), 0, 4, bytes, 4);
  BufferTools.copyIntoByteBuffer(packFlags(), 0, 2, bytes, 8);
 }