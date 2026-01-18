 @Override
 public String getGrouping() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_GROUPING_OBSELETE : ID_GROUPING);
  if (frameData != null && frameData.getText() != null) return frameData.getText().toString();
  return null;
 }