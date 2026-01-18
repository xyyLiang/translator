 private void initCustomTag(SeekableByteChannel seekableByteChannel) throws IOException {
  int bufferLength = (int) (getLength() - (endOffset + 1));
  if (hasId3v1Tag()) bufferLength -= ID3v1Tag.TAG_LENGTH;
  if (bufferLength <= 0) {
   customTag = null;
  } else {
   ByteBuffer byteBuffer = ByteBuffer.allocate(bufferLength);
   seekableByteChannel.position(endOffset + 1);
   byteBuffer.clear();
   int bytesRead = seekableByteChannel.read(byteBuffer);
   customTag = byteBuffer.array();
   if (bytesRead < bufferLength) throw new IOException("Not enough bytes read");
  }
 }