  private static void encodeChar(char c, StringBuilder sb) {
    if (c >= ' ' && c <= '?') {
      sb.append(c);
    } else if (c >= '@' && c <= '^') {
      sb.append((char) (c - 64));
    } else {
      HighLevelEncoder.illegalCharacter(c);
    }
  }