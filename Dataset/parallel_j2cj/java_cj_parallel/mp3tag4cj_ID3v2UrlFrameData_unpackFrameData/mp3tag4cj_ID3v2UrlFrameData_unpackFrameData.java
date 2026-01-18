 @Override
 protected void unpackFrameData(byte[] bytes) {
  int marker = BufferTools.indexOfTerminatorForEncoding(bytes, 1, bytes[0]);
  if (marker >= 0) {
   description = new EncodedText(bytes[0], BufferTools.copyBuffer(bytes, 1, marker - 1));
   marker += description.getTerminator().length;
  } else {
   description = new EncodedText(bytes[0], "");
   marker = 1;
  }
  try {
   url = BufferTools.byteBufferToString(bytes, marker, bytes.length - marker);
  } catch (UnsupportedEncodingException e) {
   url = "";
  }
 }