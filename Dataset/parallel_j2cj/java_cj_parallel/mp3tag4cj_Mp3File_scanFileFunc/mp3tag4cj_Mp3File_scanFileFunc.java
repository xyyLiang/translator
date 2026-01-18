 private void scanFile(SeekableByteChannel seekableByteChannel) throws IOException, InvalidDataException {
  ByteBuffer byteBuffer = ByteBuffer.allocate(bufferLength);
  int fileOffset = preScanFile(seekableByteChannel);
  seekableByteChannel.position(fileOffset);
  boolean lastBlock = false;
  int lastOffset = fileOffset;
  while (!lastBlock) {
   byteBuffer.clear();
   int bytesRead = seekableByteChannel.read(byteBuffer);
   byte[] bytes = byteBuffer.array();
   if (bytesRead < bufferLength) lastBlock = true;
   if (bytesRead >= MINIMUM_BUFFER_LENGTH) {
    while (true) {
     try {
      int offset = 0;
      if (startOffset < 0) {
       offset = scanBlockForStart(bytes, bytesRead, fileOffset, offset);
       if (startOffset >= 0 && !scanFile) {
        return;
       }
       lastOffset = startOffset;
      }
      offset = scanBlock(bytes, bytesRead, fileOffset, offset);
      fileOffset += offset;
      seekableByteChannel.position(fileOffset);
      break;
     } catch (InvalidDataException e) {
      if (frameCount < 2) {
       startOffset = -1;
       xingOffset = -1;
       frameCount = 0;
       bitrates.clear();
       lastBlock = false;
       fileOffset = lastOffset + 1;
       if (fileOffset == 0)
        throw new InvalidDataException("Valid start of mpeg frames not found", e);
       seekableByteChannel.position(fileOffset);
       break;
      }
      return;
     }
    }
   }
  }
 }
