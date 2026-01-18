 @Override
 protected void unpackFrameData(byte[] bytes) {
  int marker = BufferTools.indexOfTerminator(bytes, 1, 1);
  if (marker >= 0) {
   try {
    mimeType = BufferTools.byteBufferToString(bytes, 1, marker - 1);
   } catch (UnsupportedEncodingException e) {
    mimeType = "image/unknown";
   }
  } else {
   mimeType = "image/unknown";
  }
  pictureType = bytes[marker + 1];
  marker += 2;
  int marker2 = BufferTools.indexOfTerminatorForEncoding(bytes, marker, bytes[0]);
  if (marker2 >= 0) {
   description = new EncodedText(bytes[0], BufferTools.copyBuffer(bytes, marker, marker2 - marker));
   marker2 += description.getTerminator().length;
  } else {
   description = new EncodedText(bytes[0], "");
   marker2 = marker;
  }
  imageData = BufferTools.copyBuffer(bytes, marker2, bytes.length - marker2);
 }