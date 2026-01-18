    private static void addPattern(Collection<int[]> patterns,
                                  int patternIndex,
                                  int[] checkSum,
                                  int[] checkWeight,
                                  int position) {
      patterns.add(Code128Reader.CODE_PATTERNS[patternIndex]);
      if (position != 0) {
        checkWeight[0]++;
      }
      checkSum[0] += patternIndex * checkWeight[0];
    }

    private static boolean isDigit(char c) {
      return c >= '0' && c <= '9';
    }

    private boolean canEncode(CharSequence contents, Charset charset,int position) {
      char c = contents.charAt(position);
      switch (charset) {
        case A: return c == ESCAPE_FNC_1 ||
                       c == ESCAPE_FNC_2 ||
                       c == ESCAPE_FNC_3 ||
                       c == ESCAPE_FNC_4 ||
                       A.indexOf(c) >= 0;
        case B: return c == ESCAPE_FNC_1 ||
                       c == ESCAPE_FNC_2 ||
                       c == ESCAPE_FNC_3 ||
                       c == ESCAPE_FNC_4 ||
                       B.indexOf(c) >= 0;
        case C: return c == ESCAPE_FNC_1 ||
                       (position + 1 < contents.length() &&
                        isDigit(c) &&
                        isDigit(contents.charAt(position + 1)));
        default: return false;
      }
    }
