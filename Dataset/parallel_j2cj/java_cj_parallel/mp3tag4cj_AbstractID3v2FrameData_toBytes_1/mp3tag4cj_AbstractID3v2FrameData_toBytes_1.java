 @Override
 public byte[] toBytes() throws NotSupportedException {
  byte[] bytes = new byte[getLength()];
  packTag(bytes);
  return bytes;
 }