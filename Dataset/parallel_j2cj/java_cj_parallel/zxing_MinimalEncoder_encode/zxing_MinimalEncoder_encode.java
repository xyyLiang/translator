    private boolean[] encode(String contents) {
      memoizedCost = new int[4][contents.length()];
      minPath = new Latch[4][contents.length()];

      encode(contents, Charset.NONE, 0);

      Collection<int[]> patterns = new ArrayList<>();
      int[] checkSum = new int[] {0};
      int[] checkWeight = new int[] {1};
      int length = contents.length();
      Charset charset = Charset.NONE;
      for (int i = 0; i < length; i++) {
        Latch latch = minPath[charset.ordinal()][i];
        switch (latch) {
          case A:
            charset = Charset.A;
            addPattern(patterns, i == 0 ? CODE_START_A : CODE_CODE_A, checkSum, checkWeight, i);
            break;
          case B:
            charset = Charset.B;
            addPattern(patterns, i == 0 ? CODE_START_B : CODE_CODE_B, checkSum, checkWeight, i);
            break;
          case C:
            charset = Charset.C;
            addPattern(patterns, i == 0 ? CODE_START_C : CODE_CODE_C, checkSum, checkWeight, i);
            break;
          case SHIFT:
            addPattern(patterns, CODE_SHIFT, checkSum, checkWeight, i);
            break;
        }
        if (charset == Charset.C) {
          if (contents.charAt(i) == ESCAPE_FNC_1) {
            addPattern(patterns, CODE_FNC_1, checkSum, checkWeight, i);
          } else {
            addPattern(patterns, Integer.parseInt(contents.substring(i, i + 2)), checkSum, checkWeight, i);
            assert i + 1 < length; //the algorithm never leads to a single trailing digit in character set C
            if (i + 1 < length) {
              i++;
            }
          }
        } else { // charset A or B
          int patternIndex;
          switch (contents.charAt(i)) {
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
              if (charset == Charset.A && latch != Latch.SHIFT ||
                  charset == Charset.B && latch == Latch.SHIFT) {
                patternIndex = CODE_FNC_4_A;
              } else {
                patternIndex = CODE_FNC_4_B;
              }
              break;
            default:
              patternIndex = contents.charAt(i) - ' ';
          }
          if ((charset == Charset.A && latch != Latch.SHIFT ||
               charset == Charset.B && latch == Latch.SHIFT) &&
               patternIndex < 0) {
            patternIndex += '`';
          }
          addPattern(patterns, patternIndex, checkSum, checkWeight, i);
        }
      }
      memoizedCost = null;
      minPath = null;
      return produceResult(patterns, checkSum[0]);
    }
