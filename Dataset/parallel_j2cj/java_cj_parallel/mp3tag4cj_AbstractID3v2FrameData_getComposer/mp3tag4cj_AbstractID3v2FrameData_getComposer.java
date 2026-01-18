 @Override
 public String getComposer() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_COMPOSER_OBSELETE : ID_COMPOSER);
  if (frameData != null && frameData.getText() != null) return frameData.getText().toString();
  return null;
 }