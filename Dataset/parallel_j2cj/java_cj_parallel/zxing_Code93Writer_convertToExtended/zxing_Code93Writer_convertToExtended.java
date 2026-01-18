  static String convertToExtended(String contents) {
    int length = contents.length();
    StringBuilder extendedContent = new StringBuilder(length * 2);
    for (int i = 0; i < length; i++) {
      char character = contents.charAt(i);
      // ($)=a, (%)=b, (/)=c, (+)=d. see Code93Reader.ALPHABET_STRING
      if (character == 0) {
        // NUL: (%)U
        extendedContent.append("bU");
      } else if (character <= 26) {
        // SOH - SUB: ($)A - ($)Z
        extendedContent.append('a');
        extendedContent.append((char) ('A' + character - 1));
      } else if (character <= 31) {
        // ESC - US: (%)A - (%)E
        extendedContent.append('b');
        extendedContent.append((char) ('A' + character - 27));
      } else if (character == ' ' || character == '$' || character == '%' || character == '+') {
        // space $ % +
        extendedContent.append(character);
      } else if (character <= ',') {
        // ! " # & ' ( ) * ,: (/)A - (/)L
        extendedContent.append('c');
        extendedContent.append((char) ('A' + character - '!'));
      } else if (character <= '9') {
        extendedContent.append(character);
      } else if (character == ':') {
        // :: (/)Z
        extendedContent.append("cZ");
      } else if (character <= '?') {
        // ; - ?: (%)F - (%)J
        extendedContent.append('b');
        extendedContent.append((char) ('F' + character - ';'));
      } else if (character == '@') {
        // @: (%)V
        extendedContent.append("bV");
      } else if (character <= 'Z') {
        // A - Z
        extendedContent.append(character);
      } else if (character <= '_') {
        // [ - _: (%)K - (%)O
        extendedContent.append('b');
        extendedContent.append((char) ('K' + character - '['));
      } else if (character == '`') {
        // `: (%)W
        extendedContent.append("bW");
      } else if (character <= 'z') {
        // a - z: (*)A - (*)Z
        extendedContent.append('d');
        extendedContent.append((char) ('A' + character - 'a'));
      } else if (character <= 127) {
        // { - DEL: (%)P - (%)T
        extendedContent.append('b');
        extendedContent.append((char) ('P' + character - '{'));
      } else {
        throw new IllegalArgumentException(
          "Requested content contains a non-encodable character: '" + character + "'");
      }
    }
    return extendedContent.toString();
  }
