 private int unpackFooter(byte[] bytes, int offset) throws InvalidDataException {
  if (!FOOTER_TAG.equals(BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, offset, FOOTER_TAG.length()))) {
   throw new InvalidDataException("Invalid footer");
  }
  return FOOTER_LENGTH;
 }