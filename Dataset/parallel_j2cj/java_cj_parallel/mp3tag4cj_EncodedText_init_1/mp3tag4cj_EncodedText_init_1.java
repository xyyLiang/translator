 public EncodedText(String string) throws IllegalArgumentException {
  for (byte textEncoding : textEncodingFallback) {
   this.textEncoding = textEncoding;
   value = stringToBytes(string, characterSetForTextEncoding(textEncoding));
   if (value != null && this.toString() != null) {
    this.stripBomAndTerminator();
    return;
   }
  }
  throw new IllegalArgumentException("Invalid string, could not find appropriate encoding");
 }