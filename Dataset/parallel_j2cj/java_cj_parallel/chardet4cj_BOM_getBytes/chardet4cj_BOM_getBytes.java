  public final byte[] getBytes() {
   final int length = bytes.length;
   final byte[] result = new byte[length];

   // make a defensive copy
   System.arraycopy(bytes, 0, result, 0, length);

   return result;
  }