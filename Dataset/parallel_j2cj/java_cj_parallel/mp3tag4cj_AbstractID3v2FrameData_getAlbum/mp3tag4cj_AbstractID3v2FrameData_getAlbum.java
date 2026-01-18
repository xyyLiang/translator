 @Override
 public String getAlbum() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_ALBUM_OBSELETE : ID_ALBUM);
  if (frameData != null && frameData.getText() != null) return frameData.getText().toString();
  return null;
 }