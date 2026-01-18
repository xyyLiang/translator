 public EncodedText(byte textEncoding, byte[] value) {
  // if encoding type 1 and big endian BOM is present, switch to big endian
  if ((textEncoding == TEXT_ENCODING_UTF_16) &&
    (textEncodingForBytesFromBOM(value) == TEXT_ENCODING_UTF_16BE)) {
   this.textEncoding = TEXT_ENCODING_UTF_16BE;
  } else {
   this.textEncoding = textEncoding;
  }
  this.value = value;
  this.stripBomAndTerminator();
 }