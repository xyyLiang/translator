  private void elide(int start, int end) {
    if (sanitizedJson == null) {
      sanitizedJson = new StringBuilder(jsonish.length() + 16);
    }
    sanitizedJson.append(jsonish, cleaned, start);
    cleaned = end;
  }