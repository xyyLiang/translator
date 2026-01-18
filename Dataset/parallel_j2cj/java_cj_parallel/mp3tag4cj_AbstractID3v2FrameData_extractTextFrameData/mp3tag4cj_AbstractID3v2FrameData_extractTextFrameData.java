 protected ID3v2TextFrameData extractTextFrameData(String id) {
  ID3v2FrameSet frameSet = frameSets.get(id);
  if (frameSet != null) {
   ID3v2Frame frame = frameSet.getFrames().get(0);
   ID3v2TextFrameData frameData;
   try {
    frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), frame.getData());
    return frameData;
   } catch (InvalidDataException e) {
    // do nothing
   }
  }
  return null;
 }