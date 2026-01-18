 private int unpackHeader(byte[] bytes) throws UnsupportedTagException, InvalidDataException {
  int majorVersion = bytes[MAJOR_VERSION_OFFSET];
  int minorVersion = bytes[MINOR_VERSION_OFFSET];
  version = majorVersion + "." + minorVersion;
  if (majorVersion != 2 && majorVersion != 3 && majorVersion != 4) {
   throw new UnsupportedTagException("Unsupported version " + version);
  }
  unpackFlags(bytes);
  if ((bytes[FLAGS_OFFSET] & 0x0F) != 0) throw new UnsupportedTagException("Unrecognised bits in header");
  dataLength = BufferTools.unpackSynchsafeInteger(bytes[DATA_LENGTH_OFFSET], bytes[DATA_LENGTH_OFFSET + 1], bytes[DATA_LENGTH_OFFSET + 2], bytes[DATA_LENGTH_OFFSET + 3]);
  if (dataLength < 1) throw new InvalidDataException("Zero size tag");
  return HEADER_LENGTH;
 }
