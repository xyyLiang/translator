 public static byte[] packSynchsafeInteger(int i) {
  byte[] bytes = new byte[4];
  packSynchsafeInteger(i, bytes, 0);
  return bytes;
 }