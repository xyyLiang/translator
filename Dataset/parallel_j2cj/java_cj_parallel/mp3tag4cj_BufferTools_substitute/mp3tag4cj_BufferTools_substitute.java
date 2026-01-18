 public static String substitute(String s, String replaceThis, String withThis) {
  if (replaceThis.length() < 1 || !s.contains(replaceThis)) {
   return s;
  }
  StringBuilder newString = new StringBuilder();
  int lastPosition = 0;
  int position = 0;
  while ((position = s.indexOf(replaceThis, position)) >= 0) {
   if (position > lastPosition) {
    newString.append(s, lastPosition, position);
   }
   if (withThis != null) {
    newString.append(withThis);
   }
   lastPosition = position + replaceThis.length();
   position++;
  }
  if (lastPosition < s.length()) {
   newString.append(s.substring(lastPosition));
  }
  return newString.toString();
 }