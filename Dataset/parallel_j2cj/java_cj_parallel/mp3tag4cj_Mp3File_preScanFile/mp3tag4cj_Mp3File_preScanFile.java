 protected int preScanFile(SeekableByteChannel seekableByteChannel) {
  ByteBuffer byteBuffer = ByteBuffer.allocate(AbstractID3v2Tag.HEADER_LENGTH);
  try {
   seekableByteChannel.position(0);
   byteBuffer.clear();
   int bytesRead = seekableByteChannel.read(byteBuffer);
   if (bytesRead == AbstractID3v2Tag.HEADER_LENGTH) {
    try {
     byte[] bytes = byteBuffer.array();
     ID3v2TagFactory.sanityCheckTag(bytes);
     return AbstractID3v2Tag.HEADER_LENGTH + BufferTools.unpackSynchsafeInteger(bytes[AbstractID3v2Tag.DATA_LENGTH_OFFSET], bytes[AbstractID3v2Tag.DATA_LENGTH_OFFSET + 1], bytes[AbstractID3v2Tag.DATA_LENGTH_OFFSET + 2], bytes[AbstractID3v2Tag.DATA_LENGTH_OFFSET + 3]);
    } catch (NoSuchTagException | UnsupportedTagException e) {
     // do nothing
    }
   }
  } catch (IOException e) {
   // do nothing
  }
  return 0;
 }