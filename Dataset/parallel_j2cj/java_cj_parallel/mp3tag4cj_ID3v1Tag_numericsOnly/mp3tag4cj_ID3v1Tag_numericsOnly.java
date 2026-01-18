 private String numericsOnly(String s) {
  StringBuilder stringBuffer = new StringBuilder();
  for (int i = 0; i < s.length(); i++) {
   char ch = s.charAt(i);
   if (ch >= '0' && ch <= '9') {
    stringBuffer.append(ch);
   } else {
    break;
   }
  }
  return stringBuffer.toString();
 }