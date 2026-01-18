 private void initId3v1Tag(SeekableByteChannel seekableByteChannel) throws IOException {
  ByteBuffer byteBuffer = ByteBuffer.allocate(ID3v1Tag.TAG_LENGTH);
  seekableByteChannel.position(getLength() - ID3v1Tag.TAG_LENGTH);
  byteBuffer.clear();
  int bytesRead = seekableByteChannel.read(byteBuffer);
  if (bytesRead < ID3v1Tag.TAG_LENGTH) throw new IOException("Not enough bytes read");
  try {
   id3v1Tag = new ID3v1Tag(byteBuffer.array());
  } catch (NoSuchTagException e) {
   id3v1Tag = null;
  }
 }