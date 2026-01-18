 private byte getFlags() {
  byte b = 0;

  if (isRoot) {
   b |= 0x01;
  }

  if (isOrdered) {
   b |= 0x02;
  }
  return b;
 }