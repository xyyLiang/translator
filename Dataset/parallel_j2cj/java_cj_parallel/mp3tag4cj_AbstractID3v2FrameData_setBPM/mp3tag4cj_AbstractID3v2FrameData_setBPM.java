 @Override
 public void setBPM(int bpm) {
  if (bpm >= 0) {
   invalidateDataLength();
   ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(Integer.toString(bpm)));
   addFrame(createFrame(ID_BPM, frameData.toBytes()), true);
  }
 }