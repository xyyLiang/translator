  private static String encodeToCodewords(CharSequence sb) {
    int v = (1600 * sb.charAt(0)) + (40 * sb.charAt(1)) + sb.charAt(2) + 1;
    char cw1 = (char) (v / 256);
    char cw2 = (char) (v % 256);
    return new String(new char[] {cw1, cw2});
  }
