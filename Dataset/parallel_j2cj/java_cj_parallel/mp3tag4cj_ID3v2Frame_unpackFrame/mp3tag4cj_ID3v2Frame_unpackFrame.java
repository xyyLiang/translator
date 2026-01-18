 protected final void unpackFrame(byte[] buffer, int offset) throws InvalidDataException {
  int dataOffset = unpackHeader(buffer, offset);
  sanityCheckUnpackedHeader();
  data = BufferTools.copyBuffer(buffer, dataOffset, dataLength);
 }