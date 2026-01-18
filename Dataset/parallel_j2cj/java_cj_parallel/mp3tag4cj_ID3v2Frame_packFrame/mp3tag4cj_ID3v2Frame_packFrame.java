 public void packFrame(byte[] bytes, int offset) throws NotSupportedException {
  packHeader(bytes, offset);
  BufferTools.copyIntoByteBuffer(data, 0, data.length, bytes, offset + HEADER_LENGTH);
 }