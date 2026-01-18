 @Override
 protected void unpackFrameData(byte[] bytes) {
  String filetype;
  try {
   filetype = BufferTools.byteBufferToString(bytes, 1, 3);
  } catch (UnsupportedEncodingException e) {
   filetype = "unknown";
  }
  mimeType = "image/" + filetype.toLowerCase();
  pictureType = bytes[4];
  int marker = BufferTools.indexOfTerminatorForEncoding(bytes, 5, bytes[0]);
  if (marker >= 0) {
   description = new EncodedText(bytes[0], BufferTools.copyBuffer(bytes, 5, marker - 5));
   marker += description.getTerminator().length;
  } else {
   description = new EncodedText(bytes[0], "");
   marker = 1;
  }
  imageData = BufferTools.copyBuffer(bytes, marker, bytes.length - marker);
 }