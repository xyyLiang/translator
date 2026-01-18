 private int scanBlockForStart(byte[] bytes, int bytesRead, int absoluteOffset, int offset) {
  while (offset < bytesRead - MINIMUM_BUFFER_LENGTH) {
   if (bytes[offset] == (byte) 0xFF && (bytes[offset + 1] & (byte) 0xE0) == (byte) 0xE0) {
    try {
     MpegFrame frame = new MpegFrame(bytes[offset], bytes[offset + 1], bytes[offset + 2], bytes[offset + 3]);
     if (xingOffset < 0 && isXingFrame(bytes, offset)) {
      xingOffset = absoluteOffset + offset;
      xingBitrate = frame.getBitrate();
      offset += frame.getLengthInBytes();
     } else {
      startOffset = absoluteOffset + offset;
      channelMode = frame.getChannelMode();
      emphasis = frame.getEmphasis();
      layer = frame.getLayer();
      modeExtension = frame.getModeExtension();
      sampleRate = frame.getSampleRate();
      version = frame.getVersion();
      copyright = frame.isCopyright();
      original = frame.isOriginal();
      frameCount++;
      addBitrate(frame.getBitrate());
      offset += frame.getLengthInBytes();
      return offset;
     }
    } catch (InvalidDataException e) {
     offset++;
    }
   } else {
    offset++;
   }
  }
  return offset;
 }
