 @Override
 protected void unpackDataLength(byte[] buffer, int offset) {
  dataLength = BufferTools.unpackInteger((byte) 0, buffer[offset + DATA_LENGTH_OFFSET], buffer[offset + DATA_LENGTH_OFFSET + 1], buffer[offset + DATA_LENGTH_OFFSET + 2]);
 }