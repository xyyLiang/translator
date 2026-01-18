  State appendFLGn(int eci) {
    State result = shiftAndAppend(HighLevelEncoder.MODE_PUNCT, 0); // 0: FLG(n)
    Token token = result.token;
    int bitsAdded = 3;
    if (eci < 0) {
      token = token.add(0, 3); // 0: FNC1
    } else if (eci > 999999) {
      throw new IllegalArgumentException("ECI code must be between 0 and 999999");
    } else {
      byte[] eciDigits = Integer.toString(eci).getBytes(StandardCharsets.ISO_8859_1);
      token = token.add(eciDigits.length, 3); // 1-6: number of ECI digits
      for (byte eciDigit : eciDigits) {
        token = token.add(eciDigit - '0' + 2, 4);
      }
      bitsAdded += eciDigits.length * 4;
    }
    return new State(token, mode, 0, bitCount + bitsAdded);
  }