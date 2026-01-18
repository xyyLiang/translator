 public static int sizeUnsynchronisationWouldAdd(byte[] bytes) {
  int count = 0;
  for (int i = 0; i < bytes.length - 1; i++) {
   if (bytes[i] == (byte) 0xff && ((bytes[i + 1] & (byte) 0xe0) == (byte) 0xe0 || bytes[i + 1] == 0)) {
    count++;
   }
  }
  if (bytes.length > 0 && bytes[bytes.length - 1] == (byte) 0xff) count++;
  return count;
 }