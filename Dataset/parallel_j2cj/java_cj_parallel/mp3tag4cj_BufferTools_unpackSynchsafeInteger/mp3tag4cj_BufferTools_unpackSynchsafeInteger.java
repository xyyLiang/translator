 public static int unpackSynchsafeInteger(byte b1, byte b2, byte b3, byte b4) {
  int value = ((byte) (b4 & 0x7f));
  value += shiftByte((byte) (b3 & 0x7f), -7);
  value += shiftByte((byte) (b2 & 0x7f), -14);
  value += shiftByte((byte) (b1 & 0x7f), -21);
  return value;
 }