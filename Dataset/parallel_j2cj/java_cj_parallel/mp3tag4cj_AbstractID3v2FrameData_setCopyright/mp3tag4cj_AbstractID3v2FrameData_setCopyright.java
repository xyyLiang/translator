 @Override
 public void setCopyright(String copyright) {
  if (copyright != null && copyright.length() > 0) {
   invalidateDataLength();
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(copyright));
   addFrame(createFrame(ID_COPYRIGHT, frameData.toBytes()), true);
  }
 }