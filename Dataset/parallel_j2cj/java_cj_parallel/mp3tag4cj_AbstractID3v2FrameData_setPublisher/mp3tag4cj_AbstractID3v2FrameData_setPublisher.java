 @Override
 public void setPublisher(String publisher) {
  if (publisher != null && publisher.length() > 0) {
   invalidateDataLength();
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(publisher));
   addFrame(createFrame(ID_PUBLISHER, frameData.toBytes()), true);
  }
 }