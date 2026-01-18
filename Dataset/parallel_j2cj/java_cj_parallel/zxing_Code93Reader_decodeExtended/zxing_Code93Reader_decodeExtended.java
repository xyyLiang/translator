  private static String decodeExtended(CharSequence encoded) throws FormatException {
    int length = encoded.length();
    StringBuilder decoded = new StringBuilder(length);
    for (int i = 0; i < length; i++) {
      char c = encoded.charAt(i);
      if (c >= 'a' && c <= 'd') {
        if (i >= length - 1) {
          throw FormatException.getFormatInstance();
        }
        char next = encoded.charAt(i + 1);
        char decodedChar = '\0';
        switch (c) {
          case 'd':
            // +A to +Z map to a to z
            if (next >= 'A' && next <= 'Z') {
              decodedChar = (char) (next + 32);
            } else {
              throw FormatException.getFormatInstance();
            }
            break;
          case 'a':
            // $A to $Z map to control codes SH to SB
            if (next >= 'A' && next <= 'Z') {
              decodedChar = (char) (next - 64);
            } else {
              throw FormatException.getFormatInstance();
            }
            break;
          case 'b':
            if (next >= 'A' && next <= 'E') {
              // %A to %E map to control codes ESC to USep
              decodedChar = (char) (next - 38);
            } else if (next >= 'F' && next <= 'J') {
              // %F to %J map to ; < = > ?
              decodedChar = (char) (next - 11);
            } else if (next >= 'K' && next <= 'O') {
              // %K to %O map to [ \ ] ^ _
              decodedChar = (char) (next + 16);
            } else if (next >= 'P' && next <= 'T') {
              // %P to %T map to { | } ~ DEL
              decodedChar = (char) (next + 43);
            } else if (next == 'U') {
              // %U map to NUL
              decodedChar = '\0';
            } else if (next == 'V') {
              // %V map to @
              decodedChar = '@';
            } else if (next == 'W') {
              // %W map to `
              decodedChar = '`';
            } else if (next >= 'X' && next <= 'Z') {
              // %X to %Z all map to DEL (127)
              decodedChar = 127;
            } else {
              throw FormatException.getFormatInstance();
            }
            break;
          case 'c':
            // /A to /O map to ! to , and /Z maps to :
            if (next >= 'A' && next <= 'O') {
              decodedChar = (char) (next - 32);
            } else if (next == 'Z') {
              decodedChar = ':';
            } else {
              throw FormatException.getFormatInstance();
            }
            break;
        }
        decoded.append(decodedChar);
        // bump up i again since we read two characters
        i++;
      } else {
        decoded.append(c);
      }
    }
    return decoded.toString();
  }