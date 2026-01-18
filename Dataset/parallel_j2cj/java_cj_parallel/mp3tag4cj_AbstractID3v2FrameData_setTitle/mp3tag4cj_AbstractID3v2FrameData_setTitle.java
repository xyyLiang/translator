 @Override
 public void setTitle(String title) {
  if (title != null && title.length() > 0) {
   invalidateDataLength();
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(title));
   addFrame(createFrame(ID_TITLE, frameData.toBytes()), true);
  }
 }