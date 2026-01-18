 @Override
 public void setGenreDescription(String text) {
  ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(text));
  ID3v2FrameSet frameSet = getFrameSets().get(ID_GENRE);
  if (frameSet == null) {
   getFrameSets().put(ID_GENRE, frameSet = new ID3v2FrameSet(ID_GENRE));
  }
  frameSet.clear();
  frameSet.addFrame(createFrame(ID_GENRE, frameData.toBytes()));
 }