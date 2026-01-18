 private static String characterSetForTextEncoding(byte textEncoding) {
  try {
   return characterSets[textEncoding];
  } catch (ArrayIndexOutOfBoundsException e) {
   throw new IllegalArgumentException("Invalid text encoding " + textEncoding);
  }
 }