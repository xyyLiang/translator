 @Override
 public void setTrack(String track) {
  if (track != null && track.length() > 0) {
   invalidateDataLength();
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(track));
   addFrame(createFrame(ID_TRACK, frameData.toBytes()), true);
  }
 }