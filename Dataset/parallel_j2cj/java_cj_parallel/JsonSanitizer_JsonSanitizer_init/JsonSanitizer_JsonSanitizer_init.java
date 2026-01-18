  JsonSanitizer(String jsonish, int maximumNestingDepth) {
    this.maximumNestingDepth = Math.min(Math.max(1, maximumNestingDepth),MAXIMUM_NESTING_DEPTH);
    if (SUPER_VERBOSE_AND_SLOW_LOGGING) {
      System.err.println("\n" + jsonish + "\n========");
    }
    this.jsonish = jsonish != null ? jsonish : "null";
  }