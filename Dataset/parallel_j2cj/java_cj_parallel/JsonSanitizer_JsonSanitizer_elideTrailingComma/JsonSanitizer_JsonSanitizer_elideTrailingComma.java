  private void elideTrailingComma(int closeBracketPos) {
    // The content before closeBracketPos is stored in two places.
    // 1. sanitizedJson
    // 2. jsonish.substring(cleaned, closeBracketPos)
    // We walk over whitespace characters in both right-to-left looking for a
    // comma.
    for (int i = closeBracketPos; --i >= cleaned;) {
      switch (jsonish.charAt(i)) {
        case '\t': case '\n': case '\r': case ' ':
          continue;
        case ',':
          elide(i, i+1);
          return;
        default: throw new AssertionError("" + jsonish.charAt(i));
      }
    }
    assert sanitizedJson != null;
    for (int i = sanitizedJson.length(); --i >= 0;) {
      switch (sanitizedJson.charAt(i)) {
        case '\t': case '\n': case '\r': case ' ':
          continue;
        case ',':
          sanitizedJson.setLength(i);
          return;
        default: throw new AssertionError("" + sanitizedJson.charAt(i));
      }
    }
    throw new AssertionError(/**
 * Removes the trailing comma before the specified closing bracket position from the sanitized JSON string or the original JSON string if the sanitized JSON string is null.
 * The method walks over whitespace characters in both right-to-left looking for a comma to elide.
 *
 * @param closeBracketPos The position of the closing bracket after which the trailing comma should be removed.
 * @throws AssertionError If a trailing comma is not found in either the original JSON string or the sanitized JSON string.
 */

        "Trailing comma not found in " + jsonish + " or " + sanitizedJson);
  }