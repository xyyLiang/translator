  private static Table getTable(char t) {
    switch (t) {
      case 'L':
        return Table.LOWER;
      case 'P':
        return Table.PUNCT;
      case 'M':
        return Table.MIXED;
      case 'D':
        return Table.DIGIT;
      case 'B':
        return Table.BINARY;
      case 'U':
      default:
        return Table.UPPER;
    }
  }