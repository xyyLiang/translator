 private static AbstractID3v2Tag createID3v22Tag(byte[] bytes) throws NoSuchTagException, UnsupportedTagException, InvalidDataException {
  ID3v22Tag tag = new ID3v22Tag(bytes);
  if (tag.getFrameSets().isEmpty()) {
   tag = new ID3v22Tag(bytes, true);
  }
  return tag;
 }