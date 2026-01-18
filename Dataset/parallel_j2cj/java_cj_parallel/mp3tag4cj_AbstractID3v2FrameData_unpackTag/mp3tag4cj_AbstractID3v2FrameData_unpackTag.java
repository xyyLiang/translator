 private void unpackTag(byte[] bytes) throws NoSuchTagException, UnsupportedTagException, InvalidDataException {
  ID3v2TagFactory.sanityCheckTag(bytes);
  int offset = unpackHeader(bytes);
  try {
   if (extendedHeader) {
    offset = unpackExtendedHeader(bytes, offset);
   }
   int framesLength = dataLength;
   if (footer) framesLength -= 10;
   offset = unpackFrames(bytes, offset, framesLength);
   if (footer) {
    offset = unpackFooter(bytes, dataLength);
   }
  } catch (ArrayIndexOutOfBoundsException e) {
   throw new InvalidDataException("Premature end of tag", e);
  }
 }
