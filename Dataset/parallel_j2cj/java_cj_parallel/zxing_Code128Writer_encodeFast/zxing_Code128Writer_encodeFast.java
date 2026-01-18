  private static boolean[] encodeFast(String contents, int forcedCodeSet) {
    int length = contents.length();

    Collection<int[]> patterns = new ArrayList<>(); // temporary storage for patterns
    int checkSum = 0;
    int checkWeight = 1;
    int codeSet = 0; // selected code (CODE_CODE_B or CODE_CODE_C)
    int position = 0; // position in contents

    while (position < length) {
      //Select code to use
      int newCodeSet;
      if (forcedCodeSet == -1) {
        newCodeSet = chooseCode(contents, position, codeSet);
      } else {
        newCodeSet = forcedCodeSet;
      }

      //Get the pattern index
      int patternIndex;
      if (newCodeSet == codeSet) {
        // Encode the current character
        // First handle escapes
        switch (contents.charAt(position)) {
          case ESCAPE_FNC_1:
            patternIndex = CODE_FNC_1;
            break;
          case ESCAPE_FNC_2:
            patternIndex = CODE_FNC_2;
            break;
          case ESCAPE_FNC_3:
            patternIndex = CODE_FNC_3;
            break;
          case ESCAPE_FNC_4:
            if (codeSet == CODE_CODE_A) {
              patternIndex = CODE_FNC_4_A;
            } else {
              patternIndex = CODE_FNC_4_B;
            }
            break;
          default:
            // Then handle normal characters otherwise
            switch (codeSet) {
              case CODE_CODE_A:
                patternIndex = contents.charAt(position) - ' ';
                if (patternIndex < 0) {
                  // everything below a space character comes behind the underscore in the code patterns table
                  patternIndex += '`';
                }
                break;
              case CODE_CODE_B:
                patternIndex = contents.charAt(position) - ' ';
                break;
              default:
                // CODE_CODE_C
                if (position + 1 == length) {
                  // this is the last character, but the encoding is C, which always encodes two characers
                  throw new IllegalArgumentException("Bad number of characters for digit only encoding.");
                }
                patternIndex = Integer.parseInt(contents.substring(position, position + 2));
                position++; // Also incremented below
                break;
            }
        }
        position++;
      } else {
        // Should we change the current code?
        // Do we have a code set?
        if (codeSet == 0) {
          // No, we don't have a code set
          switch (newCodeSet) {
            case CODE_CODE_A:
              patternIndex = CODE_START_A;
              break;
            case CODE_CODE_B:
              patternIndex = CODE_START_B;
              break;
            default:
              patternIndex = CODE_START_C;
              break;
          }
        } else {
          // Yes, we have a code set
          patternIndex = newCodeSet;
        }
        codeSet = newCodeSet;
      }

      // Get the pattern
      patterns.add(Code128Reader.CODE_PATTERNS[patternIndex]);

      // Compute checksum
      checkSum += patternIndex * checkWeight;
      if (position != 0) {
        checkWeight++;
      }
    }
    return produceResult(patterns, checkSum);
  }
