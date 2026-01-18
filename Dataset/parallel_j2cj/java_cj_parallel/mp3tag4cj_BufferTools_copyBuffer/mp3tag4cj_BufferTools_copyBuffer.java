 public static byte[] copyBuffer(byte[] bytes, int offset, int length) {
  byte[] copy = new byte[length];
  if (length > 0) {
   System.arraycopy(bytes, offset, copy, 0, length);
  }
  return copy;
 }