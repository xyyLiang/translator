 protected ID3v2Frame createFrame(String id, byte[] data) {
  if (obseleteFormat) return new ID3v2ObseleteFrame(id, data);
  else return new ID3v2Frame(id, data);
 }