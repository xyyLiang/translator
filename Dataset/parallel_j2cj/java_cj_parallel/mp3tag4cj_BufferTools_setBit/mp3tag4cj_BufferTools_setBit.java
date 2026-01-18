 public static byte setBit(byte b, int bitPosition, boolean value) {
  byte newByte;
  if (value) {
   newByte = (byte) (b | ((byte) 0x01 << bitPosition));
  } else {
   newByte = (byte) (b & (~((byte) 0x01 << bitPosition)));
  }
  return newByte;
 }