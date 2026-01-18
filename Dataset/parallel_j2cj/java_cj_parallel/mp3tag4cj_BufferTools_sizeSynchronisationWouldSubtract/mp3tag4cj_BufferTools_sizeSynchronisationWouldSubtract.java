 public static int sizeSynchronisationWouldSubtract(byte[] bytes) {
  int count = 0;
  for (int i = 0; i < bytes.length - 2; i++) {
   if (bytes[i] == (byte) 0xff && bytes[i + 1] == 0 && ((bytes[i + 2] & (byte) 0xe0) == (byte) 0xe0 || bytes[i + 2] == 0)) {
    count++;
   }
  }
  if (bytes.length > 1 && bytes[bytes.length - 2] == (byte) 0xff && bytes[bytes.length - 1] == 0) count++;
  return count;
 }