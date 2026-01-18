 public static String padStringRight(String s, int length, char padWith) {
  if (s.length() >= length) return s;
  StringBuilder stringBuffer = new StringBuilder(s);
  while (stringBuffer.length() < length) {
   stringBuffer.append(padWith);
  }
  return stringBuffer.toString();
 }