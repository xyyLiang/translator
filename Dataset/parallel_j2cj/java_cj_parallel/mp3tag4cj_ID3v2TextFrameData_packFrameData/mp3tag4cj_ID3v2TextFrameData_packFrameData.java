 @Override
 protected byte[] packFrameData() {
  byte[] bytes = new byte[getLength()];
  if (text != null) {
   bytes[0] = text.getTextEncoding();
   byte[] textBytes = text.toBytes(true, false);
   if (textBytes.length > 0) {
    BufferTools.copyIntoByteBuffer(textBytes, 0, textBytes.length, bytes, 1);
   }
  }
  return bytes;
 }