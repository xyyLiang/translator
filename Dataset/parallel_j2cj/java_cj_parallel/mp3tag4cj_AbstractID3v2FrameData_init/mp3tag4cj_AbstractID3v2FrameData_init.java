 public AbstractID3v2Tag(byte[] bytes, boolean obseleteFormat) throws NoSuchTagException, UnsupportedTagException, InvalidDataException {
  frameSets = new TreeMap<>();
  this.obseleteFormat = obseleteFormat;
  unpackTag(bytes);
 }