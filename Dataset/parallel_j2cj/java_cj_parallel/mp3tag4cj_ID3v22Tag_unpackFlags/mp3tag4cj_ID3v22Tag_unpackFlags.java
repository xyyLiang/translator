 @Override
 protected void unpackFlags(byte[] bytes) {
  unsynchronisation = BufferTools.checkBit(bytes[FLAGS_OFFSET], UNSYNCHRONISATION_BIT);
  compression = BufferTools.checkBit(bytes[FLAGS_OFFSET], COMPRESSION_BIT);
 }