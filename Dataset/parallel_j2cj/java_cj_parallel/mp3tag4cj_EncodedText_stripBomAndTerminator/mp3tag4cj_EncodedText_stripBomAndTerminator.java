 private void stripBomAndTerminator() {
  int leadingCharsToRemove = 0;
  if (value.length >= 2 && ((value[0] == (byte) 0xfe && value[1] == (byte) 0xff) || (value[0] == (byte) 0xff && value[1] == (byte) 0xfe))) {
   leadingCharsToRemove = 2;
  } else if (value.length >= 3 && (value[0] == (byte) 0xef && value[1] == (byte) 0xbb && value[2] == (byte) 0xbf)) {
   leadingCharsToRemove = 3;
  }
  int trailingCharsToRemove = 0;
  byte[] terminator = terminators[textEncoding];
  if (value.length - leadingCharsToRemove >= terminator.length) {
   boolean haveTerminator = true;
   for (int i = 0; i < terminator.length; i++) {
    if (value[value.length - terminator.length + i] != terminator[i]) {
     haveTerminator = false;
     break;
    }
   }
   if (haveTerminator) trailingCharsToRemove = terminator.length;
  }
  if (leadingCharsToRemove + trailingCharsToRemove > 0) {
   int newLength = value.length - leadingCharsToRemove - trailingCharsToRemove;
   byte[] newValue = new byte[newLength];
   if (newLength > 0) {
    System.arraycopy(value, leadingCharsToRemove, newValue, 0, newValue.length);
   }
   value = newValue;
  }
 }
