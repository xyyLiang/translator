 @Override
 protected void unpackFrameData(byte[] bytes) {
  text = new EncodedText(bytes[0], BufferTools.copyBuffer(bytes, 1, bytes.length - 1));
 }