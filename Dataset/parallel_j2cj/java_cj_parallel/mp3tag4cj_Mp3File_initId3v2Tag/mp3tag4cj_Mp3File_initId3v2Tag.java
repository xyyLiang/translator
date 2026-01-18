 private void initId3v2Tag(SeekableByteChannel seekableByteChannel) throws IOException, UnsupportedTagException, InvalidDataException {
  if (xingOffset == 0 || startOffset == 0) {
   id3v2Tag = null;
  } else {
   int bufferLength;
   if (hasXingFrame()) bufferLength = xingOffset;
   else bufferLength = startOffset;
   ByteBuffer byteBuffer = ByteBuffer.allocate(bufferLength);
   seekableByteChannel.position(0);
   byteBuffer.clear();
   int bytesRead = seekableByteChannel.read(byteBuffer);
   if (bytesRead < bufferLength) throw new IOException("Not enough bytes read");
   try {
    id3v2Tag = ID3v2TagFactory.createTag(byteBuffer.array());
   } catch (NoSuchTagException e) {
    id3v2Tag = null;
   }
  }
 }
