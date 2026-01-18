 private int packSpecifiedFrames(byte[] bytes, int offset, String onlyId, String notId) throws NotSupportedException {
  for (ID3v2FrameSet frameSet : frameSets.values()) {
   if ((onlyId == null || onlyId.equals(frameSet.getId())) && (notId == null || !notId.equals(frameSet.getId()))) {
    for (ID3v2Frame frame : frameSet.getFrames()) {
     if (frame.getDataLength() > 0) {
      byte[] frameData = frame.toBytes();
      BufferTools.copyIntoByteBuffer(frameData, 0, frameData.length, bytes, offset);
      offset += frameData.length;
     }
    }
   }
  }
  return offset;
 }