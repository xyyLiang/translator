 protected int unpackFrames(byte[] bytes, int offset, int framesLength) {
  int currentOffset = offset;
  while (currentOffset <= framesLength) {
   ID3v2Frame frame;
   try {
    frame = createFrame(bytes, currentOffset);
    addFrame(frame, false);
    currentOffset += frame.getLength();
   } catch (InvalidDataException e) {
    break;
   }
  }
  return currentOffset;
 }