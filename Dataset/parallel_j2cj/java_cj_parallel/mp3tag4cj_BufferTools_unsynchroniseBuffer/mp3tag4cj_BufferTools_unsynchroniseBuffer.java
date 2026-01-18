 public static byte[] unsynchroniseBuffer(byte[] bytes) {
  // unsynchronisation is replacing instances of:
  // 11111111 111xxxxx with 11111111 00000000 111xxxxx and
  // 11111111 00000000 with 11111111 00000000 00000000
  int count = sizeUnsynchronisationWouldAdd(bytes);
  if (count == 0) return bytes;
  byte[] newBuffer = new byte[bytes.length + count];
  int j = 0;
  for (int i = 0; i < bytes.length - 1; i++) {
   newBuffer[j++] = bytes[i];
   if (bytes[i] == (byte) 0xff && ((bytes[i + 1] & (byte) 0xe0) == (byte) 0xe0 || bytes[i + 1] == 0)) {
    newBuffer[j++] = 0;
   }
  }
  newBuffer[j++] = bytes[bytes.length - 1];
  if (bytes[bytes.length - 1] == (byte) 0xff) {
   newBuffer[j++] = 0;
  }
  return newBuffer;
 }