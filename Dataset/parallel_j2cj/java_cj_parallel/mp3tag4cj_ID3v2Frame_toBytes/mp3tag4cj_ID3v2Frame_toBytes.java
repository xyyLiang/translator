 public byte[] toBytes() throws NotSupportedException {
  byte[] bytes = new byte[getLength()];
  packFrame(bytes, 0);
  return bytes;
 }