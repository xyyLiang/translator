  private boolean canonicalizeNumber(int start, int end) {
    elide(start, start);
    int sanStart = sanitizedJson.length();

    normalizeNumber(start, end);

    // Ensure that the number is on the output buffer.  Since this method is
    // only called when we are quoting a number that appears where a property
    // name is expected, we can force the sanitized form to contain it without
    // affecting the fast-track for already valid inputs.
    elide(end, end);
    int sanEnd = sanitizedJson.length();

    return canonicalizeNumber(sanitizedJson, sanStart, sanEnd);
  }
