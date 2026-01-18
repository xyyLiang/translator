 @Override
 public void setDate(String date) {
  if (date != null && date.length() > 0) {
   invalidateDataLength();
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(date));
   addFrame(createFrame(ID_DATE, frameData.toBytes()), true);
  }
 }