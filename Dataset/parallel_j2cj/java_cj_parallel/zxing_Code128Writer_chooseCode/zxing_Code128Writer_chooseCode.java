  private static int chooseCode(CharSequence value, int start, int oldCode) {
    CType lookahead = findCType(value, start);
    if (lookahead == CType.ONE_DIGIT) {
      if (oldCode == CODE_CODE_A) {
        return CODE_CODE_A;
      }
      return CODE_CODE_B;
    }
    if (lookahead == CType.UNCODABLE) {
      if (start < value.length()) {
        char c = value.charAt(start);
        if (c < ' ' || (oldCode == CODE_CODE_A && (c < '`' || (c >= ESCAPE_FNC_1 && c <= ESCAPE_FNC_4)))) {
          // can continue in code A, encodes ASCII 0 to 95 or FNC1 to FNC4
          return CODE_CODE_A;
        }
      }
      return CODE_CODE_B; // no choice
    }
    if (oldCode == CODE_CODE_A && lookahead == CType.FNC_1) {
      return CODE_CODE_A;
    }
    if (oldCode == CODE_CODE_C) { // can continue in code C
      return CODE_CODE_C;
    }
    if (oldCode == CODE_CODE_B) {
      if (lookahead == CType.FNC_1) {
        return CODE_CODE_B; // can continue in code B
      }
      // Seen two consecutive digits, see what follows
      lookahead = findCType(value, start + 2);
      if (lookahead == CType.UNCODABLE || lookahead == CType.ONE_DIGIT) {
        return CODE_CODE_B; // not worth switching now
      }
      if (lookahead == CType.FNC_1) { // two digits, then FNC_1...
        lookahead = findCType(value, start + 3);
        if (lookahead == CType.TWO_DIGITS) { // then two more digits, switch
          return CODE_CODE_C;
        } else {
          return CODE_CODE_B; // otherwise not worth switching
        }
      }
      // At this point, there are at least 4 consecutive digits.
      // Look ahead to choose whether to switch now or on the next round.
      int index = start + 4;
      while ((lookahead = findCType(value, index)) == CType.TWO_DIGITS) {
        index += 2;
      }
      if (lookahead == CType.ONE_DIGIT) { // odd number of digits, switch later
        return CODE_CODE_B;
      }
      return CODE_CODE_C; // even number of digits, switch now
    }
    // Here oldCode == 0, which means we are choosing the initial code
    if (lookahead == CType.FNC_1) { // ignore FNC_1
      lookahead = findCType(value, start + 1);
    }
    if (lookahead == CType.TWO_DIGITS) { // at least two digits, start in code C
      return CODE_CODE_C;
    }
    return CODE_CODE_B;
  }
