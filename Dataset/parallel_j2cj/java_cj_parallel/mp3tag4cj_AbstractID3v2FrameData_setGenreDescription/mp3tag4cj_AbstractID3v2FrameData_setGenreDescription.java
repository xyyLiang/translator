 @Override
 public void setGenreDescription(String text) throws IllegalArgumentException {
  int genreNum = ID3v1Genres.matchGenreDescription(text);
  if (genreNum < 0) {
   throw new IllegalArgumentException("Unknown genre: " + text);
  }
  setGenre(genreNum);
 }
