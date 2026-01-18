 @Override
 public String getGenreDescription() {
  ID3v2TextFrameData frameData = extractTextFrameData(obseleteFormat ? ID_GENRE_OBSELETE : ID_GENRE);
  if (frameData == null || frameData.getText() == null) {
   return null;
  }
  String text = frameData.getText().toString();
  if (text != null) {
   int genreNum = getGenre(text);
   if (genreNum >= 0 && genreNum < ID3v1Genres.GENRES.length) {
    return ID3v1Genres.GENRES[genreNum];
   } else {
    String description = extractGenreDescription(text);
    if (description != null && description.length() > 0) {
     return description;
    }
   }
  }
  return null;
 }
