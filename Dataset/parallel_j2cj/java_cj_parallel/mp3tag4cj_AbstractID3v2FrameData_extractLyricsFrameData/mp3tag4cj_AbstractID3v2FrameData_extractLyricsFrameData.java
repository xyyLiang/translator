 protected ID3v2CommentFrameData extractLyricsFrameData(String id) {
  ID3v2FrameSet frameSet = frameSets.get(id);
  if (frameSet != null) {
   for (ID3v2Frame frame : frameSet.getFrames()) {
    ID3v2CommentFrameData frameData;
    try {
     frameData = new ID3v2CommentFrameData(useFrameUnsynchronisation(), frame.getData());
     return frameData;
    } catch (InvalidDataException e) {
     // Do nothing
    }
   }
  }
  return null;
 }