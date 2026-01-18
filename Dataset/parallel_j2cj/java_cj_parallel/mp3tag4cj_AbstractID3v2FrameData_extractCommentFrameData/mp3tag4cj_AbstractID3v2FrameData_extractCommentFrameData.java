 private ID3v2CommentFrameData extractCommentFrameData(String id, boolean itunes) {
  ID3v2FrameSet frameSet = frameSets.get(id);
  if (frameSet != null) {
   for (ID3v2Frame frame : frameSet.getFrames()) {
    ID3v2CommentFrameData frameData;
    try {
     frameData = new ID3v2CommentFrameData(useFrameUnsynchronisation(), frame.getData());
     if (itunes && ITUNES_COMMENT_DESCRIPTION.equals(frameData.getDescription().toString())) {
      return frameData;
     } else if (!itunes) {
      return frameData;
     }
    } catch (InvalidDataException e) {
     // Do nothing
    }
   }
  }
  return null;
 }