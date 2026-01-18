  private void replace(int start, int end, char ch) {
    elide(start, end);
    sanitizedJson.append(ch);
  }