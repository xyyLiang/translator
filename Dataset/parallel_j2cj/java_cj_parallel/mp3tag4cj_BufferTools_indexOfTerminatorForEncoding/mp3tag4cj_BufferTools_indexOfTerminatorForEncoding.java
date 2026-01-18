 public static int indexOfTerminatorForEncoding(byte[] bytes, int fromIndex, int encoding) {
  int terminatorLength = (encoding == EncodedText.TEXT_ENCODING_UTF_16 || encoding == EncodedText.TEXT_ENCODING_UTF_16BE) ? 2 : 1;
  return indexOfTerminator(bytes, fromIndex, terminatorLength);
 }