 protected void addFrame(ID3v2Frame frame, boolean replace) {
  ID3v2FrameSet frameSet = frameSets.get(frame.getId());
  if (frameSet == null) {
   frameSet = new ID3v2FrameSet(frame.getId());
   frameSet.addFrame(frame);
   frameSets.put(frame.getId(), frameSet);
  } else if (replace) {
   frameSet.clear();
   frameSet.addFrame(frame);
  } else {
   frameSet.addFrame(frame);
  }
 }