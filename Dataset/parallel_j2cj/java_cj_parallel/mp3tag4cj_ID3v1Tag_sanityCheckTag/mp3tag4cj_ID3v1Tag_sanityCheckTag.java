 private void sanityCheckTag(byte[] bytes) throws NoSuchTagException {
  if (bytes.length != TAG_LENGTH) {
   throw new NoSuchTagException("Buffer length wrong");
  }
  if (!TAG.equals(BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, 0, TAG.length()))) {
   throw new NoSuchTagException();
  }
 }