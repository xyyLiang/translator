 @Override
 public String getTitle() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_TITLE_OBSELETE : ID_TITLE);
  if (frameData != null && frameData.getText() != null) return frameData.getText().toString();
  return null;
 }