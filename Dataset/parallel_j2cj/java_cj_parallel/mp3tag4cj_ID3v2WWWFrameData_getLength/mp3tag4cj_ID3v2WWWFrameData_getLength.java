 @Override
 protected byte[] packFrameData() {
  byte[] bytes = new byte[getLength()];
  if (url != null && url.length() > 0) {
   try {
    BufferTools.stringIntoByteBuffer(url, 0, url.length(), bytes, 0);
   } catch (UnsupportedEncodingException e) {
   }
  }
  return bytes;
 }