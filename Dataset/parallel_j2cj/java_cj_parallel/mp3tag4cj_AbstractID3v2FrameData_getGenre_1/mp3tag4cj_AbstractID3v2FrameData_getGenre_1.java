 @Override
 public int getGenre() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_GENRE_OBSELETE : ID_GENRE);
  if (frameData == null || frameData.getText() == null) {
   return -1;
  }
  return getGenre(frameData.getText().toString());
 }