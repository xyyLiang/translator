 @Override
 protected byte[] packDataLength() {
  return BufferTools.packSynchsafeInteger(dataLength);
 }