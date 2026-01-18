 @Override
 public String getPartOfSet() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_PART_OF_SET_OBSELETE : ID_PART_OF_SET);
  if (frameData != null && frameData.getText() != null) return frameData.getText().toString();
  return null;
 }