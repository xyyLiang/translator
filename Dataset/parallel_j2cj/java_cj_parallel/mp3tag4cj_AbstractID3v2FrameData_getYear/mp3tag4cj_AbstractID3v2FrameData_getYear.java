 @Override
 public String getYear() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_YEAR_OBSELETE : ID_YEAR);
  if (frameData != null && frameData.getText() != null) return frameData.getText().toString();
  return null;
 }