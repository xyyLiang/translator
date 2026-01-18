 public static void copyIntoByteBuffer(byte[] bytes, int offset, int length, byte[] destBuffer, int destOffset) {
  if (length > 0) {
   System.arraycopy(bytes, offset, destBuffer, destOffset, length);
  }
 }