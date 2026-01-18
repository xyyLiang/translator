 @Override
 public String getKey() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_KEY_OBSELETE : ID_KEY);
  if (frameData == null || frameData.getText() == null) {
   return null;
  }
  return frameData.getText().toString();
 }