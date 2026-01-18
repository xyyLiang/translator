 public static void packSynchsafeInteger(int i, byte[] bytes, int offset) {
  bytes[offset + 3] = (byte) (i & 0x7f);
  bytes[offset + 2] = (byte) ((i >> 7) & 0x7f);
  bytes[offset + 1] = (byte) ((i >> 14) & 0x7f);
  bytes[offset + 0] = (byte) ((i >> 21) & 0x7f);
 }