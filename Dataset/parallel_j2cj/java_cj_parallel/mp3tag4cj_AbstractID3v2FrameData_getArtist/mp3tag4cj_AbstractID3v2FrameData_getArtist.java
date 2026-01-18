 @Override
 public String getArtist() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_ARTIST_OBSELETE : ID_ARTIST);
  if (frameData != null && frameData.getText() != null) return frameData.getText().toString();
  return null;
 }