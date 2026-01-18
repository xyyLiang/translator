 @Override
 public String getTrack() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_TRACK_OBSELETE : ID_TRACK);
  if (frameData != null && frameData.getText() != null) return frameData.getText().toString();
  return null;
 }