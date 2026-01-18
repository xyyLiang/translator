 public byte[] toBytes(boolean includeBom, boolean includeTerminator) {
  characterSetForTextEncoding(textEncoding); // ensured textEncoding is valid
  int newLength = value.length + (includeBom ? boms[textEncoding].length : 0) + (includeTerminator ? getTerminator().length : 0);
  if (newLength == value.length) {
   return value;
  } else {
   byte[] bytes = new byte[newLength];
   int i = 0;
   if (includeBom) {
    byte[] bom = boms[textEncoding];
    if (bom.length > 0) {
     System.arraycopy(boms[textEncoding], 0, bytes, i, boms[textEncoding].length);
     i += boms[textEncoding].length;
    }
   }
   if (value.length > 0) {
    System.arraycopy(value, 0, bytes, i, value.length);
    i += value.length;
   }
   if (includeTerminator) {
    byte[] terminator = getTerminator();
    if (terminator.length > 0) {
     System.arraycopy(terminator, 0, bytes, i, terminator.length);
    }
   }
   return bytes;
  }
 }
