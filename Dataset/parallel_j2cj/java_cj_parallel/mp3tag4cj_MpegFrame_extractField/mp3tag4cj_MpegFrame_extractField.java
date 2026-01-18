 protected int extractField(long frameHeader, long bitMask) {
  int shiftBy = 0;
  for (int i = 0; i <= 31; i++) {
   if (((bitMask >> i) & 1) != 0) {
    shiftBy = i;
    break;
   }
  }
  return (int) ((frameHeader >> shiftBy) & (bitMask >> shiftBy));
 }