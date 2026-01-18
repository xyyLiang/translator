  private static char patternToChar(int pattern) throws NotFoundException {
    for (int i = 0; i < CHARACTER_ENCODINGS.length; i++) {
      if (CHARACTER_ENCODINGS[i] == pattern) {
        return ALPHABET_STRING.charAt(i);
      }
    }
    if (pattern == ASTERISK_ENCODING) {
      return '*';
    }
    throw NotFoundException.getNotFoundInstance();
  }