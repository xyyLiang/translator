  private void replace(int start, int end, String s) {
    elide(start, end);
    sanitizedJson.append(s);
  }