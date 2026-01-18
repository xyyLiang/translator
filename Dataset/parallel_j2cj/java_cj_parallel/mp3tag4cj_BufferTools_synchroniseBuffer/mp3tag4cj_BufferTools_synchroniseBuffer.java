 public static byte[] synchroniseBuffer(byte[] bytes) {
  // synchronisation is replacing instances of:
  // 11111111 00000000 111xxxxx with 11111111 111xxxxx and
  // 11111111 00000000 00000000 with 11111111 00000000
  int count = sizeSynchronisationWouldSubtract(bytes);
  if (count == 0) return bytes;
  byte[] newBuffer = new byte[bytes.length - count];
  int i = 0;
  for (int j = 0; j < newBuffer.length - 1; j++) {
   newBuffer[j] = bytes[i];
   if (bytes[i] == (byte) 0xff && bytes[i + 1] == 0 && ((bytes[i + 2] & (byte) 0xe0) == (byte) 0xe0 || bytes[i + 2] == 0)) {
    i++;
   }
   i++;
  }
  newBuffer[newBuffer.length - 1] = bytes[i];
  return newBuffer;
 }