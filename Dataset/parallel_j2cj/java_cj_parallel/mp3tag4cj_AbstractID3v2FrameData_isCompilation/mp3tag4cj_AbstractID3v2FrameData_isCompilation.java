 @Override
 public boolean isCompilation() {
  // unofficial frame used by iTunes
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_COMPILATION_OBSELETE : ID_COMPILATION);
  if (frameData != null && frameData.getText() != null) return "1".equals(frameData.getText().toString());
  return false;
 }