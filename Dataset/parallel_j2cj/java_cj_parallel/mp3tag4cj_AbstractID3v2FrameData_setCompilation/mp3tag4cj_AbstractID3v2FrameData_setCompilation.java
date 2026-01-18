 @Override
 public void setCompilation(boolean compilation) {
  invalidateDataLength();
  ID3v2TextFrameData frameData = new ID3v2TextFrameData(useFrameUnsynchronisation(), new EncodedText(compilation ? "1" : "0"));
  addFrame(createFrame(ID_COMPILATION, frameData.toBytes()), true);
 }