  boolean canEncode(Mode mode, char c) {
    switch (mode) {
      case KANJI: return isDoubleByteKanji(c);
      case ALPHANUMERIC: return isAlphanumeric(c);
      case NUMERIC: return isNumeric(c);
      case BYTE: return true; // any character can be encoded as byte(s). Up to the caller to manage splitting into
                              // multiple bytes when String.getBytes(Charset) return more than one byte.
      default:
        return false;
    }
  }