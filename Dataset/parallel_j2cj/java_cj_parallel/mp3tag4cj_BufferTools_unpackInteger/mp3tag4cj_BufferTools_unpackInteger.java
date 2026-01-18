 public static int unpackInteger(byte b1, byte b2, byte b3, byte b4) {
  int value = b4 & 0xff;
  value += BufferTools.shiftByte(b3, -8);
  value += BufferTools.shiftByte(b2, -16);
  value += BufferTools.shiftByte(b1, -24);
  return value;
 }