 private int getGenre(String text) {
  if (text != null && text.length() > 0) {
   try {
    return extractGenreNumber(text);
   } catch (NumberFormatException e) { // match genre description
    String description = extractGenreDescription(text);
    return ID3v1Genres.matchGenreDescription(description);
   }
  }
  return -1;
 }