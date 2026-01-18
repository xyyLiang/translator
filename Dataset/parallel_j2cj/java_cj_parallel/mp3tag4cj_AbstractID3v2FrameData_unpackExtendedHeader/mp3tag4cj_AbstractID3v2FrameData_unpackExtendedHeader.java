 private int unpackExtendedHeader(byte[] bytes, int offset) {
  extendedHeaderLength = BufferTools.unpackSynchsafeInteger(bytes[offset], bytes[offset + 1], bytes[offset + 2], bytes[offset + 3]) + 4;
  extendedHeaderData = BufferTools.copyBuffer(bytes, offset + 4, extendedHeaderLength);
  return extendedHeaderLength;
 }