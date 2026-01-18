 public static int matchGenreDescription(String description) {
  if (description != null && description.length() > 0) {
   for (int i = 0; i < ID3v1Genres.GENRES.length; i++) {
    if (ID3v1Genres.GENRES[i].equalsIgnoreCase(description)) {
     return i;
    }
   }
  }
  return -1;
 }