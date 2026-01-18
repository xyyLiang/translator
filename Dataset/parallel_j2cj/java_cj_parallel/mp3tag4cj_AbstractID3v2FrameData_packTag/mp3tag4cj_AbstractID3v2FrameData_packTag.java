 public void packTag(byte[] bytes) throws NotSupportedException {
  int offset = packHeader(bytes, 0);
  if (extendedHeader) {
   offset = packExtendedHeader(bytes, offset);
  }
  offset = packFrames(bytes, offset);
  if (footer) {
   offset = packFooter(bytes, dataLength);
  }
 }