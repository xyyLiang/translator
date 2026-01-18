 public static String trimStringRight(String s) {
  int endPosition = s.length() - 1;
  char endChar;
  while (endPosition >= 0) {
   endChar = s.charAt(endPosition);
   if (endChar > 32) {
    break;
   }
   endPosition--;
  }
  if (endPosition == s.length() - 1) return s;
  else if (endPosition < 0) return "";
  return s.substring(0, endPosition + 1);
 }