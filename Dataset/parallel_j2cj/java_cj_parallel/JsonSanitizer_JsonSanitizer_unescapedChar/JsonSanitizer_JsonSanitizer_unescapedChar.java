  private static int unescapedChar(String s, int left) {
    int n = s.length();
    if (left >= n) {
      return 0;
    }
    char c = s.charAt(left);
    if (c == '\\') {
      if (left + 1 == n) {
        return 0x10000;
      }
      char nc = s.charAt(left + 1);
      switch (nc) {
        case '0': case '1': case '2': case '3':
        case '4': case '5': case '6': case '7': {
          int octalStart = left + 1;
          int octalEnd = octalStart;
          ++octalEnd;
          if (octalEnd < n && isOct(s.charAt(octalEnd))) {
            ++octalEnd;
            if (nc <= '3' && octalEnd < n && isOct(s.charAt(octalEnd))) {
              ++octalEnd;
            }
          }
          int value = 0;
          for (int j = octalStart; j < octalEnd; ++j) {
            char digit = s.charAt(j);
            value = (value << 3) | (digit - '0');
          }
          return ((octalEnd - left) << 16) | value;
        }
        case 'x':
          if (left + 3 < n) {
            char d0 = s.charAt(left + 2);
            char d1 = s.charAt(left + 3);
            if (isHex(d0) && isHex(d1)) {
              return 0x40000 | (hexVal(d0) << 4) | hexVal(d1);
            }
          }
          break;
        case 'u':
          if (left + 5 < n) {
            char d0 = s.charAt(left + 2);
            char d1 = s.charAt(left + 3);
            char d2 = s.charAt(left + 4);
            char d3 = s.charAt(left + 5);
            if (isHex(d0) && isHex(d1) && isHex(d2) && isHex(d3)) {
              return 0x60000 |
                      (hexVal(d0) << 12) | (hexVal(d1) << 8) | (hexVal(d2) << 4) | hexVal(d3);
            }
          }
          break;
        case 'b': return (0x20000 | '\b');
        case 'f': return (0x20000 | '\f');
        case 'n': return 0x2000A;
        case 'r': return 0x2000D;
        case 't': return 0x20009;
        case 'v': return 0x20008;
        default: break;
      }
      return (0x20000) | nc;
    } else {
      return 0x10000 | c;
    }
  }
