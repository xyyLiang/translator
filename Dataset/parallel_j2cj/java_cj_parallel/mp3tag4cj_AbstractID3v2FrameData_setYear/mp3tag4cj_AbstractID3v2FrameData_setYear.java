 @Override
 public void setYear(String year) {
  if (year != null && year.length() > 0) {
   invalidateDataLength();
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(year));
   addFrame(createFrame(ID_YEAR, frameData.toBytes()), true);
  }
 }