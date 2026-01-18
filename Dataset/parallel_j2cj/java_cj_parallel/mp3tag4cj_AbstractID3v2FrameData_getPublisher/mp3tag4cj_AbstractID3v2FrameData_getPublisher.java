 @Override
 public String getPublisher() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_PUBLISHER_OBSELETE : ID_PUBLISHER);
  if (frameData != null && frameData.getText() != null) return frameData.getText().toString();
  return null;
 }