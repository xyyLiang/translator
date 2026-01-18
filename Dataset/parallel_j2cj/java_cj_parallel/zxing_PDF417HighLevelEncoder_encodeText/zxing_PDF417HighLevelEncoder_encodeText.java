  private static int encodeText(ECIInput input,
                                int startpos,
                                int count,
                                StringBuilder sb,
                                int initialSubmode) throws WriterException {
    StringBuilder tmp = new StringBuilder(count);
    int submode = initialSubmode;
    int idx = 0;
    while (true) {
      if (input.isECI(startpos + idx)) {
        encodingECI(input.getECIValue(startpos + idx), sb);
        idx++;
      } else {
        char ch = input.charAt(startpos + idx);
        switch (submode) {
          case SUBMODE_ALPHA:
            if (isAlphaUpper(ch)) {
              if (ch == ' ') {
                tmp.append((char) 26); //space
              } else {
                tmp.append((char) (ch - 65));
              }
            } else {
              if (isAlphaLower(ch)) {
                submode = SUBMODE_LOWER;
                tmp.append((char) 27); //ll
                continue;
              } else if (isMixed(ch)) {
                submode = SUBMODE_MIXED;
                tmp.append((char) 28); //ml
                continue;
              } else {
                tmp.append((char) 29); //ps
                tmp.append((char) PUNCTUATION[ch]);
                break;
              }
            }
            break;
          case SUBMODE_LOWER:
            if (isAlphaLower(ch)) {
              if (ch == ' ') {
                tmp.append((char) 26); //space
              } else {
                tmp.append((char) (ch - 97));
              }
            } else {
              if (isAlphaUpper(ch)) {
                tmp.append((char) 27); //as
                tmp.append((char) (ch - 65));
                //space cannot happen here, it is also in "Lower"
                break;
              } else if (isMixed(ch)) {
                submode = SUBMODE_MIXED;
                tmp.append((char) 28); //ml
                continue;
              } else {
                tmp.append((char) 29); //ps
                tmp.append((char) PUNCTUATION[ch]);
                break;
              }
            }
            break;
          case SUBMODE_MIXED:
            if (isMixed(ch)) {
              tmp.append((char) MIXED[ch]);
            } else {
              if (isAlphaUpper(ch)) {
                submode = SUBMODE_ALPHA;
                tmp.append((char) 28); //al
                continue;
              } else if (isAlphaLower(ch)) {
                submode = SUBMODE_LOWER;
                tmp.append((char) 27); //ll
                continue;
              } else {
                if (startpos + idx + 1 < count &&
                    !input.isECI(startpos + idx + 1) &&
                    isPunctuation(input.charAt(startpos + idx + 1))) {
                  submode = SUBMODE_PUNCTUATION;
                  tmp.append((char) 25); //pl
                  continue;
                }
                tmp.append((char) 29); //ps
                tmp.append((char) PUNCTUATION[ch]);
              }
            }
            break;
          default: //SUBMODE_PUNCTUATION
            if (isPunctuation(ch)) {
              tmp.append((char) PUNCTUATION[ch]);
            } else {
              submode = SUBMODE_ALPHA;
              tmp.append((char) 29); //al
              continue;
            }
        }
        idx++;
        if (idx >= count) {
          break;
        }
      }
    }
    char h = 0;
    int len = tmp.length();
    for (int i = 0; i < len; i++) {
      boolean odd = (i % 2) != 0;
      if (odd) {
        h = (char) ((h * 30) + tmp.charAt(i));
        sb.append(h);
      } else {
        h = tmp.charAt(i);
      }
    }
    if ((len % 2) != 0) {
      sb.append((char) ((h * 30) + 29)); //ps
    }
    return submode;
  }
