 public static boolean checkBit(byte b, int bitPosition) {
  return ((b & (0x01 << bitPosition)) != 0);
 }