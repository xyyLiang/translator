 @Override
 protected byte[] packFrameData() {
  byte[] bytes = new byte[getLength()];
  if (description != null) bytes[0] = description.getTextEncoding();
  else bytes[0] = 0;
  int mimeTypeLength = 0;
  if (mimeType != null && mimeType.length() > 0) {
   mimeTypeLength = mimeType.length();
   try {
    BufferTools.stringIntoByteBuffer(mimeType, 0, mimeTypeLength, bytes, 1);
   } catch (UnsupportedEncodingException e) {
   }
  }
  int marker = mimeTypeLength + 1;
  bytes[marker++] = 0;
  bytes[marker++] = pictureType;
  if (description != null && description.toBytes().length > 0) {
   byte[] descriptionBytes = description.toBytes(true, true);
   BufferTools.copyIntoByteBuffer(descriptionBytes, 0, descriptionBytes.length, bytes, marker);
   marker += descriptionBytes.length;
  } else {
   bytes[marker++] = 0;
  }
  if (imageData != null && imageData.length > 0) {
   BufferTools.copyIntoByteBuffer(imageData, 0, imageData.length, bytes, marker);
  }
  return bytes;
 }
