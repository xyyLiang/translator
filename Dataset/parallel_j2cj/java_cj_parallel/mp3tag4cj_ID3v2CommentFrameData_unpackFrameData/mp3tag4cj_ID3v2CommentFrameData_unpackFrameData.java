 @Override
 protected void unpackFrameData(byte[] bytes) {
  try {
   language = BufferTools.byteBufferToString(bytes, 1, 3);
  } catch (UnsupportedEncodingException e) {
   language = "";
  }
  int marker = BufferTools.indexOfTerminatorForEncoding(bytes, 4, bytes[0]);
  if (marker >= 4) {
   description = new EncodedText(bytes[0], BufferTools.copyBuffer(bytes, 4, marker - 4));
   marker += description.getTerminator().length;
  } else {
   description = new EncodedText(bytes[0], "");
   marker = 4;
  }
  comment = new EncodedText(bytes[0], BufferTools.copyBuffer(bytes, marker, bytes.length - marker));
 }