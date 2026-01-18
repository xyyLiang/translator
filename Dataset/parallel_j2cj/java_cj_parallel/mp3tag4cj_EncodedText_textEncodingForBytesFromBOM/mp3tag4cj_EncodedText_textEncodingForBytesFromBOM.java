 private static byte textEncodingForBytesFromBOM(byte[] value) {
  if (value.length >= 2 && value[0] == (byte) 0xff && value[1] == (byte) 0xfe) {
   return TEXT_ENCODING_UTF_16;
  } else if (value.length >= 2 && value[0] == (byte) 0xfe && value[1] == (byte) 0xff) {
   return TEXT_ENCODING_UTF_16BE;
  } else if (value.length >= 3 && (value[0] == (byte) 0xef && value[1] == (byte) 0xbb && value[2] == (byte) 0xbf)) {
   return TEXT_ENCODING_UTF_8;
  } else {
   return TEXT_ENCODING_ISO_8859_1;
  }
 }