 public static AbstractID3v2Tag createTag(byte[] bytes) throws NoSuchTagException, UnsupportedTagException, InvalidDataException {
  sanityCheckTag(bytes);
  int majorVersion = bytes[AbstractID3v2Tag.MAJOR_VERSION_OFFSET];
  switch (majorVersion) {
   case 2:
    return createID3v22Tag(bytes);
   case 3:
    return new ID3v23Tag(bytes);
   case 4:
    return new ID3v24Tag(bytes);
  }
  throw new UnsupportedTagException("Tag version not supported");
 }