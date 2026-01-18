 public void save(String newFilename) throws IOException, NotSupportedException {
  if (path.toAbsolutePath().compareTo(Paths.get(newFilename).toAbsolutePath()) == 0) {
   throw new IllegalArgumentException("Save filename same as source filename");
  }
  try (SeekableByteChannel saveFile = Files.newByteChannel(Paths.get(newFilename), EnumSet.of(StandardOpenOption.CREATE, StandardOpenOption.TRUNCATE_EXISTING, StandardOpenOption.WRITE))) {
   if (hasId3v2Tag()) {
    ByteBuffer byteBuffer = ByteBuffer.wrap(id3v2Tag.toBytes());
    byteBuffer.rewind();
    saveFile.write(byteBuffer);
   }
   saveMpegFrames(saveFile);
   if (hasCustomTag()) {
    ByteBuffer byteBuffer = ByteBuffer.wrap(customTag);
    byteBuffer.rewind();
    saveFile.write(byteBuffer);
   }
   if (hasId3v1Tag()) {
    ByteBuffer byteBuffer = ByteBuffer.wrap(id3v1Tag.toBytes());
    byteBuffer.rewind();
    saveFile.write(byteBuffer);
   }
  }
 }