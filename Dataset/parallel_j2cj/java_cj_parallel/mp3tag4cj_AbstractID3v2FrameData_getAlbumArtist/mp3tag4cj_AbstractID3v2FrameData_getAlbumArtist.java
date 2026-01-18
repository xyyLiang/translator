 @Override
 public String getAlbumArtist() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_ALBUM_ARTIST_OBSELETE : ID_ALBUM_ARTIST);
  if (frameData != null && frameData.getText() != null) return frameData.getText().toString();
  return null;
 }