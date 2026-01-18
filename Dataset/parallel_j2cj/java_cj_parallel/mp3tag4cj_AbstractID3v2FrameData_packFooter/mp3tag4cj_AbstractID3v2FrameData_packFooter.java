 private int packFooter(byte[] bytes, int offset) {
  try {
   BufferTools.stringIntoByteBuffer(FOOTER_TAG, 0, FOOTER_TAG.length(), bytes, offset);
  } catch (UnsupportedEncodingException e) {
  }
  String[] s = version.split("\\.");
  if (s.length > 0) {
   byte majorVersion = Byte.parseByte(s[0]);
   bytes[offset + MAJOR_VERSION_OFFSET] = majorVersion;
  }
  if (s.length > 1) {
   byte minorVersion = Byte.parseByte(s[1]);
   bytes[offset + MINOR_VERSION_OFFSET] = minorVersion;
  }
  packFlags(bytes, offset);
  BufferTools.packSynchsafeInteger(getDataLength(), bytes, offset + DATA_LENGTH_OFFSET);
  return offset + FOOTER_LENGTH;
 }