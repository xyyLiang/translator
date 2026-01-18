 @Override
 protected int unpackHeader(byte[] buffer, int offset) {
  id = BufferTools.byteBufferToStringIgnoringEncodingIssues(buffer, offset + ID_OFFSET, ID_LENGTH);
  unpackDataLength(buffer, offset);
  return offset + HEADER_LENGTH;
 }