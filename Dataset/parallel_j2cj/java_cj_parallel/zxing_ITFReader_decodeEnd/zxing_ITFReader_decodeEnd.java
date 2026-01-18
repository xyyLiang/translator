  private int[] decodeEnd(BitArray row) throws NotFoundException {

    // For convenience, reverse the row and then
    // search from 'the start' for the end block
    row.reverse();
    try {
      int endStart = skipWhiteSpace(row);
      int[] endPattern;
      try {
        endPattern = findGuardPattern(row, endStart, END_PATTERN_REVERSED[0]);
      } catch (NotFoundException nfe) {
        endPattern = findGuardPattern(row, endStart, END_PATTERN_REVERSED[1]);
      }

      // The start & end patterns must be pre/post fixed by a quiet zone. This
      // zone must be at least 10 times the width of a narrow line.
      // ref: http://www.barcode-1.net/i25code.html
      validateQuietZone(row, endPattern[0]);

      // Now recalculate the indices of where the 'endblock' starts & stops to
      // accommodate
      // the reversed nature of the search
      int temp = endPattern[0];
      endPattern[0] = row.getSize() - endPattern[1];
      endPattern[1] = row.getSize() - temp;

      return endPattern;
    } finally {
      // Put the row back the right way.
      row.reverse();
    }
  }
