 @Override
 public String getDate() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_DATE_OBSELETE : ID_DATE);
  if (frameData != null && frameData.getText() != null) return frameData.getText().toString();
  return null;
 }