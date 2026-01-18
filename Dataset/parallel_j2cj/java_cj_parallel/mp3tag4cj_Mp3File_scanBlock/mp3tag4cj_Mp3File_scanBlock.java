 private int scanBlock(byte[] bytes, int bytesRead, int absoluteOffset, int offset) throws InvalidDataException {
  while (offset < bytesRead - MINIMUM_BUFFER_LENGTH) {
   MpegFrame frame = new MpegFrame(bytes[offset], bytes[offset + 1], bytes[offset + 2], bytes[offset + 3]);
   sanityCheckFrame(frame, absoluteOffset + offset);
   int newEndOffset = absoluteOffset + offset + frame.getLengthInBytes() - 1;
   if (newEndOffset < maxEndOffset()) {
    endOffset = absoluteOffset + offset + frame.getLengthInBytes() - 1;
    frameCount++;
    addBitrate(frame.getBitrate());
    offset += frame.getLengthInBytes();
   } else {
    break;
   }
  }
  return offset;
 }