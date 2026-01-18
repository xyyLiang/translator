 private void unpackFlags(byte[] buffer, int offset) {
  preserveTag = BufferTools.checkBit(buffer[offset + FLAGS1_OFFSET], PRESERVE_TAG_BIT);
  preserveFile = BufferTools.checkBit(buffer[offset + FLAGS1_OFFSET], PRESERVE_FILE_BIT);
  readOnly = BufferTools.checkBit(buffer[offset + FLAGS1_OFFSET], READ_ONLY_BIT);
  group = BufferTools.checkBit(buffer[offset + FLAGS2_OFFSET], GROUP_BIT);
  compression = BufferTools.checkBit(buffer[offset + FLAGS2_OFFSET], COMPRESSION_BIT);
  encryption = BufferTools.checkBit(buffer[offset + FLAGS2_OFFSET], ENCRYPTION_BIT);
  unsynchronisation = BufferTools.checkBit(buffer[offset + FLAGS2_OFFSET], UNSYNCHRONISATION_BIT);
  dataLengthIndicator = BufferTools.checkBit(buffer[offset + FLAGS2_OFFSET], DATA_LENGTH_INDICATOR_BIT);
 }