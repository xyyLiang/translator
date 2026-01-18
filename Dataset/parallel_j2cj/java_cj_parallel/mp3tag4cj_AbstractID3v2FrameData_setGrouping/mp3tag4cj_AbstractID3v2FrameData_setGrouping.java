 @Override
 public void setGrouping(String grouping) {
  if (grouping != null && grouping.length() > 0) {
   invalidateDataLength();
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(grouping));
   addFrame(createFrame(ID_GROUPING, frameData.toBytes()), true);
  }
 }