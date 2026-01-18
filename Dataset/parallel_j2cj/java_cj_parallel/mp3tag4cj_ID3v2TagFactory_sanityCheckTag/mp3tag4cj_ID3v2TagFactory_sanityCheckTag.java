 public static void sanityCheckTag(byte[] bytes) throws NoSuchTagException, UnsupportedTagException {
  if (bytes.length < AbstractID3v2Tag.HEADER_LENGTH) {
   throw new NoSuchTagException("Buffer too short");
  }
  if (!AbstractID3v2Tag.TAG.equals(BufferTools.byteBufferToStringIgnoringEncodingIssues(bytes, 0, AbstractID3v2Tag.TAG.length()))) {
   throw new NoSuchTagException();
  }
  int majorVersion = bytes[AbstractID3v2Tag.MAJOR_VERSION_OFFSET];
  if (majorVersion != 2 && majorVersion != 3 && majorVersion != 4) {
   int minorVersion = bytes[AbstractID3v2Tag.MINOR_VERSION_OFFSET];
   throw new UnsupportedTagException("Unsupported version 2." + majorVersion + "." + minorVersion);
  }
 }