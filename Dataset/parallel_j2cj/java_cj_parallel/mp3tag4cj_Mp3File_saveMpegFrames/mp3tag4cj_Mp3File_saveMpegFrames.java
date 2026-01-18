 private void saveMpegFrames(SeekableByteChannel saveFile) throws IOException {
  int filePos = xingOffset;
  if (filePos < 0) filePos = startOffset;
  if (filePos < 0) return;
  if (endOffset < filePos) return;
  ByteBuffer byteBuffer = ByteBuffer.allocate(bufferLength);
  try (SeekableByteChannel seekableByteChannel = Files.newByteChannel(path, StandardOpenOption.READ)) {
   seekableByteChannel.position(filePos);
   while (true) {
    byteBuffer.clear();
    int bytesRead = seekableByteChannel.read(byteBuffer);
    byteBuffer.rewind();
    if (filePos + bytesRead <= endOffset) {
     byteBuffer.limit(bytesRead);
     saveFile.write(byteBuffer);
     filePos += bytesRead;
    } else {
     byteBuffer.limit(endOffset - filePos + 1);
     saveFile.write(byteBuffer);
     break;
    }
   }
  }
 }