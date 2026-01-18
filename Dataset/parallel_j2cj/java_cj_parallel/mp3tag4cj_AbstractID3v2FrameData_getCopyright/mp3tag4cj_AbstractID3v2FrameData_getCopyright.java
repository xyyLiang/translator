 @Override
 public String getCopyright() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_COPYRIGHT_OBSELETE : ID_COPYRIGHT);
  if (frameData != null && frameData.getText() != null) return frameData.getText().toString();
  return null;
 }