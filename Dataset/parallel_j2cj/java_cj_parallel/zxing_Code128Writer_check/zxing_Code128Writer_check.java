  private static int check(String contents, Map<EncodeHintType,?> hints) {
    // Check for forced code set hint.
    int forcedCodeSet = -1;
    if (hints != null && hints.containsKey(EncodeHintType.FORCE_CODE_SET)) {
      String codeSetHint = hints.get(EncodeHintType.FORCE_CODE_SET).toString();
      switch (codeSetHint) {
        case "A":
          forcedCodeSet = CODE_CODE_A;
          break;
        case "B":
          forcedCodeSet = CODE_CODE_B;
          break;
        case "C":
          forcedCodeSet = CODE_CODE_C;
          break;
        default:
          throw new IllegalArgumentException("Unsupported code set hint: " + codeSetHint);
      }
    }

    // Check content
    int length = contents.length();
    for (int i = 0; i < length; i++) {
      char c = contents.charAt(i);
      // check for non ascii characters that are not special GS1 characters
      switch (c) {
        // special function characters
        case ESCAPE_FNC_1:
        case ESCAPE_FNC_2:
        case ESCAPE_FNC_3:
        case ESCAPE_FNC_4:
          break;
        // non ascii characters
        default:
          if (c > 127) {
            // no full Latin-1 character set available at the moment
            // shift and manual code change are not supported
            throw new IllegalArgumentException("Bad character in input: ASCII value=" + (int) c);
          }
      }
      // check characters for compatibility with forced code set
      switch (forcedCodeSet) {
        case CODE_CODE_A:
          // allows no ascii above 95 (no lower caps, no special symbols)
          if (c > 95 && c <= 127) {
            throw new IllegalArgumentException("Bad character in input for forced code set A: ASCII value=" + (int) c);
          }
          break;
        case CODE_CODE_B:
          // allows no ascii below 32 (terminal symbols)
          if (c < 32) {
            throw new IllegalArgumentException("Bad character in input for forced code set B: ASCII value=" + (int) c);
          }
          break;
        case CODE_CODE_C:
          // allows only numbers and no FNC 2/3/4
          if (c < 48 || (c > 57 && c <= 127) || c == ESCAPE_FNC_2 || c == ESCAPE_FNC_3 || c == ESCAPE_FNC_4) {
            throw new IllegalArgumentException("Bad character in input for forced code set C: ASCII value=" + (int) c);
          }
          break;
      }
    }
    return forcedCodeSet;
  }
