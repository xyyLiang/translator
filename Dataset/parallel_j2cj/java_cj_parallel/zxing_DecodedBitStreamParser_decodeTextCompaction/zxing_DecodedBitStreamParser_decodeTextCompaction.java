  private static Mode decodeTextCompaction(int[] textCompactionData,
                                           int[] byteCompactionData,
                                           int length,
                                           ECIStringBuilder result,
                                           Mode startMode) {
    // Beginning from an initial state
    // The default compaction mode for PDF417 in effect at the start of each symbol shall always be Text
    // Compaction mode Alpha sub-mode (uppercase alphabetic). A latch codeword from another mode to the Text
    // Compaction mode shall always switch to the Text Compaction Alpha sub-mode.
    Mode subMode = startMode;
    Mode priorToShiftMode = startMode;
    Mode latchedMode = startMode;
    int i = 0;
    while (i < length) {
      int subModeCh = textCompactionData[i];
      char ch = 0;
      switch (subMode) {
        case ALPHA:
          // Alpha (uppercase alphabetic)
          if (subModeCh < 26) {
            // Upper case Alpha Character
            ch = (char) ('A' + subModeCh);
          } else {
            switch (subModeCh) {
              case 26:
                ch = ' ';
                break;
              case LL:
                subMode = Mode.LOWER;
                latchedMode = subMode;
                break;
              case ML:
                subMode = Mode.MIXED;
                latchedMode = subMode;
                break;
              case PS:
                // Shift to punctuation
                priorToShiftMode = subMode;
                subMode = Mode.PUNCT_SHIFT;
                break;
              case MODE_SHIFT_TO_BYTE_COMPACTION_MODE:
                result.append((char) byteCompactionData[i]);
                break;
              case TEXT_COMPACTION_MODE_LATCH:
                subMode = Mode.ALPHA;
                latchedMode = subMode;
                break;
            }
          }
          break;

        case LOWER:
          // Lower (lowercase alphabetic)
          if (subModeCh < 26) {
            ch = (char) ('a' + subModeCh);
          } else {
            switch (subModeCh) {
              case 26:
                ch = ' ';
                break;
              case AS:
                // Shift to alpha
                priorToShiftMode = subMode;
                subMode = Mode.ALPHA_SHIFT;
                break;
              case ML:
                subMode = Mode.MIXED;
                latchedMode = subMode;
                break;
              case PS:
                // Shift to punctuation
                priorToShiftMode = subMode;
                subMode = Mode.PUNCT_SHIFT;
                break;
              case MODE_SHIFT_TO_BYTE_COMPACTION_MODE:
                result.append((char) byteCompactionData[i]);
                break;
              case TEXT_COMPACTION_MODE_LATCH:
                subMode = Mode.ALPHA;
                latchedMode = subMode;
                break;
            }
          }
          break;

        case MIXED:
          // Mixed (numeric and some punctuation)
          if (subModeCh < PL) {
            ch = MIXED_CHARS[subModeCh];
          } else {
            switch (subModeCh) {
              case PL:
                subMode = Mode.PUNCT;
                latchedMode = subMode;
                break;
              case 26:
                ch = ' ';
                break;
              case LL:
                subMode = Mode.LOWER;
                latchedMode = subMode;
                break;
              case AL:
              case TEXT_COMPACTION_MODE_LATCH:
                subMode = Mode.ALPHA;
                latchedMode = subMode;
                break;
              case PS:
                // Shift to punctuation
                priorToShiftMode = subMode;
                subMode = Mode.PUNCT_SHIFT;
                break;
              case MODE_SHIFT_TO_BYTE_COMPACTION_MODE:
                result.append((char) byteCompactionData[i]);
                break;
            }
          }
          break;

        case PUNCT:
          // Punctuation
          if (subModeCh < PAL) {
            ch = PUNCT_CHARS[subModeCh];
          } else {
            switch (subModeCh) {
              case PAL:
              case TEXT_COMPACTION_MODE_LATCH:
                subMode = Mode.ALPHA;
                latchedMode = subMode;
                break;
              case MODE_SHIFT_TO_BYTE_COMPACTION_MODE:
                result.append((char) byteCompactionData[i]);
                break;
            }
          }
          break;

        case ALPHA_SHIFT:
          // Restore sub-mode
          subMode = priorToShiftMode;
          if (subModeCh < 26) {
            ch = (char) ('A' + subModeCh);
          } else {
            switch (subModeCh) {
              case 26:
                ch = ' ';
                break;
              case TEXT_COMPACTION_MODE_LATCH:
                subMode = Mode.ALPHA;
                break;
            }
          }
          break;

        case PUNCT_SHIFT:
          // Restore sub-mode
          subMode = priorToShiftMode;
          if (subModeCh < PAL) {
            ch = PUNCT_CHARS[subModeCh];
          } else {
            switch (subModeCh) {
              case PAL:
              case TEXT_COMPACTION_MODE_LATCH:
                subMode = Mode.ALPHA;
                break;
              case MODE_SHIFT_TO_BYTE_COMPACTION_MODE:
                // PS before Shift-to-Byte is used as a padding character,
                // see 5.4.2.4 of the specification
                result.append((char) byteCompactionData[i]);
                break;
            }
          }
          break;
      }
      if (ch != 0) {
        // Append decoded character to result
        result.append(ch);
      }
      i++;
    }
    return latchedMode;
  }
