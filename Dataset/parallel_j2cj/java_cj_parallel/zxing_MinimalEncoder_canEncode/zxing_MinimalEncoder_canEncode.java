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