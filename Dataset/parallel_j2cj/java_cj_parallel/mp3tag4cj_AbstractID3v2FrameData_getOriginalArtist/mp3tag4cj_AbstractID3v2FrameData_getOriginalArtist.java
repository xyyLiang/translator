 @Override
 public String getOriginalArtist() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_ORIGINAL_ARTIST_OBSELETE : ID_ORIGINAL_ARTIST);
  if (frameData != null && frameData.getText() != null) return frameData.getText().toString();
  return null;
 }