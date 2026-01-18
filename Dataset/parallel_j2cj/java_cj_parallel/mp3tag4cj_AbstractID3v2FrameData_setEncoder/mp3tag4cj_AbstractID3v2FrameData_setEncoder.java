 @Override
 public void setEncoder(String encoder) {
  if (encoder != null && encoder.length() > 0) {
   invalidateDataLength();
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(encoder));
   addFrame(createFrame(ID_ENCODER, frameData.toBytes()), true);
  }
 }