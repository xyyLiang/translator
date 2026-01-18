 private int packExtendedHeader(byte[] bytes, int offset) {
  BufferTools.packSynchsafeInteger(extendedHeaderLength, bytes, offset);
  BufferTools.copyIntoByteBuffer(extendedHeaderData, 0, extendedHeaderData.length, bytes, offset + 4);
  return offset + 4 + extendedHeaderData.length;
 }