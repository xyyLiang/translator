 @Override
 public String getEncoder() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_ENCODER_OBSELETE : ID_ENCODER);
  if (frameData != null && frameData.getText() != null) return frameData.getText().toString();
  return null;
 }