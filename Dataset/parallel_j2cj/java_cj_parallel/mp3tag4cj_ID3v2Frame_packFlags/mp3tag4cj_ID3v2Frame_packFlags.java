 private byte[] packFlags() {
  byte[] bytes = new byte[2];
  bytes[0] = BufferTools.setBit(bytes[0], PRESERVE_TAG_BIT, preserveTag);
  bytes[0] = BufferTools.setBit(bytes[0], PRESERVE_FILE_BIT, preserveFile);
  bytes[0] = BufferTools.setBit(bytes[0], READ_ONLY_BIT, readOnly);
  bytes[1] = BufferTools.setBit(bytes[1], GROUP_BIT, group);
  bytes[1] = BufferTools.setBit(bytes[1], COMPRESSION_BIT, compression);
  bytes[1] = BufferTools.setBit(bytes[1], ENCRYPTION_BIT, encryption);
  bytes[1] = BufferTools.setBit(bytes[1], UNSYNCHRONISATION_BIT, unsynchronisation);
  bytes[1] = BufferTools.setBit(bytes[1], DATA_LENGTH_INDICATOR_BIT, dataLengthIndicator);
  return bytes;
 }