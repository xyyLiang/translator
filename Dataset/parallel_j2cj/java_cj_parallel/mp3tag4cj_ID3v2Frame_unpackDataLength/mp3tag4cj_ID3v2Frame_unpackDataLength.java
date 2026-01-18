 protected void unpackDataLength(byte[] buffer, int offset) {
  dataLength = BufferTools.unpackInteger(buffer[offset + DATA_LENGTH_OFFSET], buffer[offset + DATA_LENGTH_OFFSET + 1], buffer[offset + DATA_LENGTH_OFFSET + 2], buffer[offset + DATA_LENGTH_OFFSET + 3]);
 }