  public static String sanitize(String jsonish, int maximumNestingDepth) {
    JsonSanitizer s = new JsonSanitizer(jsonish, maximumNestingDepth);
    s.sanitize();
    return s.toString();
  }