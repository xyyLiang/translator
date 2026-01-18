 public void setRecordingTime(String recTime) {
  if (recTime != null && recTime.length() > 0) {
   invalidateDataLength();
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(recTime));
   addFrame(createFrame(ID_RECTIME, frameData.toBytes()), true);
  }
 }