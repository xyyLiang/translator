 @Override
 public byte[] toBytes() {
  byte[] bytes = new byte[TAG_LENGTH];
  packTag(bytes);
  return bytes;
 }