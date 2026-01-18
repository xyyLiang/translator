 protected ID3v2Frame createFrame(byte[] bytes, int currentOffset) throws InvalidDataException {
  if (obseleteFormat) return new ID3v2ObseleteFrame(bytes, currentOffset);
  return new ID3v2Frame(bytes, currentOffset);
 }