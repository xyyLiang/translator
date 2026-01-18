  static int getCompactedOrdinal(Mode mode) {
    if (mode == null) {
      return 0;
    }
    switch (mode) {
      case KANJI:
        return 0;
      case ALPHANUMERIC:
        return 1;
      case NUMERIC:
        return 2;
      case BYTE:
        return 3;
      default:
        throw new IllegalStateException("Illegal mode " + mode);
    }
  }
