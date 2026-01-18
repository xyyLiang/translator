  private static int numericCompaction(int[] codewords, int codeIndex, ECIStringBuilder result) throws FormatException {
    int count = 0;
    boolean end = false;

    int[] numericCodewords = new int[MAX_NUMERIC_CODEWORDS];

    while (codeIndex < codewords[0] && !end) {
      int code = codewords[codeIndex++];
      if (codeIndex == codewords[0]) {
        end = true;
      }
      if (code < TEXT_COMPACTION_MODE_LATCH) {
        numericCodewords[count] = code;
        count++;
      } else {
        switch (code) {
          case TEXT_COMPACTION_MODE_LATCH:
          case BYTE_COMPACTION_MODE_LATCH:
          case BYTE_COMPACTION_MODE_LATCH_6:
          case BEGIN_MACRO_PDF417_CONTROL_BLOCK:
          case BEGIN_MACRO_PDF417_OPTIONAL_FIELD:
          case MACRO_PDF417_TERMINATOR:
          case ECI_CHARSET:
            codeIndex--;
            end = true;
            break;
        }
      }
      if ((count % MAX_NUMERIC_CODEWORDS == 0 || code == NUMERIC_COMPACTION_MODE_LATCH || end) && count > 0) {
        // Re-invoking Numeric Compaction mode (by using codeword 902
        // while in Numeric Compaction mode) serves  to terminate the
        // current Numeric Compaction mode grouping as described in 5.4.4.2,
        // and then to start a new one grouping.
        result.append(decodeBase900toBase10(numericCodewords, count));
        count = 0;
      }
    }
    return codeIndex;
  }
