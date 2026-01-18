  public static String minify(String jsonish) {
    JsonSanitizer s = new JsonSanitizer(jsonish);
    s.sanitize();
    return minify(s.toCharSequence()).toString();
  }