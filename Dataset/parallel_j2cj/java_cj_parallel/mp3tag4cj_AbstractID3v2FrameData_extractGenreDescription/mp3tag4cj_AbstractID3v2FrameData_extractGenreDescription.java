 protected String extractGenreDescription(String genreValue) throws NumberFormatException {
  String value = genreValue.trim();
  if (value.length() > 0) {
   if (value.charAt(0) == '(') {
    int pos = value.indexOf(')');
    if (pos > 0) {
     return value.substring(pos + 1);
    }
   }
   return value;
  }
  return null;
 }