 protected int extractGenreNumber(String genreValue) throws NumberFormatException {
  String value = genreValue.trim();
  if (value.length() > 0) {
   if (value.charAt(0) == '(') {
    int pos = value.indexOf(')');
    if (pos > 0) {
     return Integer.parseInt(value.substring(1, pos));
    }
   }
  }
  return Integer.parseInt(value);
 }