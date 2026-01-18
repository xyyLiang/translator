 public static String asciiOnly(String s) {
  StringBuilder newString = new StringBuilder();
  for (int i = 0; i < s.length(); i++) {
   char ch = s.charAt(i);
   if (ch < 32 || ch > 126) {
    newString.append('?');
   } else {
    newString.append(ch);
   }
  }
  return newString.toString();
 }