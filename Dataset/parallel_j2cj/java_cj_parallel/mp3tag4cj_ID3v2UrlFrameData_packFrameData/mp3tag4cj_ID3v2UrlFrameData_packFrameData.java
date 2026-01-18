 @Override
 protected byte[] packFrameData() {
  byte[] bytes = new byte[getLength()];
  if (description != null) bytes[0] = description.getTextEncoding();
  else bytes[0] = 0;
  int marker = 1;
  if (description != null) {
   byte[] descriptionBytes = description.toBytes(true, true);
   BufferTools.copyIntoByteBuffer(descriptionBytes, 0, descriptionBytes.length, bytes, marker);
   marker += descriptionBytes.length;
  } else {
   bytes[marker++] = 0;
  }
  if (url != null && url.length() > 0) {
   try {
    BufferTools.stringIntoByteBuffer(url, 0, url.length(), bytes, marker);
   } catch (UnsupportedEncodingException e) {
   }
  }
  return bytes;
 }