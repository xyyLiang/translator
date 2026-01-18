  private static int textCompaction(int[] codewords, int codeIndex, ECIStringBuilder result) throws FormatException {
    // 2 character per codeword
    int[] textCompactionData = new int[(codewords[0] - codeIndex) * 2];
    // Used to hold the byte compaction value if there is a mode shift
    int[] byteCompactionData = new int[(codewords[0] - codeIndex) * 2];

    int index = 0;
    boolean end = false;
    Mode subMode = Mode.ALPHA;
    while ((codeIndex < codewords[0]) && !end) {
      int code = codewords[codeIndex++];
      if (code < TEXT_COMPACTION_MODE_LATCH) {
        textCompactionData[index] = code / 30;
        textCompactionData[index + 1] = code % 30;
        index += 2;
      } else {
        switch (code) {
          case TEXT_COMPACTION_MODE_LATCH:
            // reinitialize text compaction mode to alpha sub mode
            textCompactionData[index++] = TEXT_COMPACTION_MODE_LATCH;
            break;
          case BYTE_COMPACTION_MODE_LATCH:
          case BYTE_COMPACTION_MODE_LATCH_6:
          case NUMERIC_COMPACTION_MODE_LATCH:
          case BEGIN_MACRO_PDF417_CONTROL_BLOCK:
          case BEGIN_MACRO_PDF417_OPTIONAL_FIELD:
          case MACRO_PDF417_TERMINATOR:
            codeIndex--;
            end = true;
            break;
          case MODE_SHIFT_TO_BYTE_COMPACTION_MODE:
            // The Mode Shift codeword 913 shall cause a temporary
            // switch from Text Compaction mode to Byte Compaction mode.
            // This switch shall be in effect for only the next codeword,
            // after which the mode shall revert to the prevailing sub-mode
            // of the Text Compaction mode. Codeword 913 is only available
            // in Text Compaction mode; its use is described in 5.4.2.4.
            textCompactionData[index] = MODE_SHIFT_TO_BYTE_COMPACTION_MODE;
            code = codewords[codeIndex++];
            byteCompactionData[index] = code;
            index++;
            break;
          case ECI_CHARSET:
            subMode = decodeTextCompaction(textCompactionData, byteCompactionData, index, result, subMode);
            result.appendECI(codewords[codeIndex++]);
            if (codeIndex > codewords[0]) {
              throw FormatException.getFormatInstance();
            }
            textCompactionData = new int[(codewords[0] - codeIndex) * 2];
            byteCompactionData = new int[(codewords[0] - codeIndex) * 2];
            index = 0;
            break;
        }
      }
    }
    decodeTextCompaction(textCompactionData, byteCompactionData, index, result, subMode);
    return codeIndex;
  }
