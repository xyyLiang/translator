  static String encodeHighLevel(String msg, Compaction compaction, Charset encoding, boolean autoECI)
      throws WriterException {

    if (msg.isEmpty()) {
      throw new WriterException("Empty message not allowed");
    }

    if (encoding == null && !autoECI) {
      for (int i = 0; i < msg.length(); i++) {
        if (msg.charAt(i) > 255) {
          throw new WriterException("Non-encodable character detected: " + msg.charAt(i) + " (Unicode: " +
              (int) msg.charAt(i) +
              "). Consider specifying EncodeHintType.PDF417_AUTO_ECI and/or EncodeTypeHint.CHARACTER_SET.");
        }
      }
    }
    //the codewords 0..928 are encoded as Unicode characters
    StringBuilder sb = new StringBuilder(msg.length());

    ECIInput input;
    if (autoECI) {
      input = new MinimalECIInput(msg, encoding, -1);
    } else {
      input = new NoECIInput(msg);
      if (encoding == null) {
        encoding = DEFAULT_ENCODING;
      } else if (!DEFAULT_ENCODING.equals(encoding)) {
        CharacterSetECI eci = CharacterSetECI.getCharacterSetECI(encoding);
        if (eci != null) {
          encodingECI(eci.getValue(), sb);
        }
      }
    }

    int len = input.length();
    int p = 0;
    int textSubMode = SUBMODE_ALPHA;

    // User selected encoding mode
    switch (compaction) {
      case TEXT:
        encodeText(input, p, len, sb, textSubMode);
        break;
      case BYTE:
        if (autoECI) {
          encodeMultiECIBinary(input, 0, input.length(), TEXT_COMPACTION, sb);
        } else {
          byte[] msgBytes = input.toString().getBytes(encoding);
          encodeBinary(msgBytes, p, msgBytes.length, BYTE_COMPACTION, sb);
        }
        break;
      case NUMERIC:
        sb.append((char) LATCH_TO_NUMERIC);
        encodeNumeric(input, p, len, sb);
        break;
      default:
        int encodingMode = TEXT_COMPACTION; //Default mode, see 4.4.2.1
        while (p < len) {
          while (p < len && input.isECI(p)) {
            encodingECI(input.getECIValue(p), sb);
            p++;
          }
          if (p >= len) {
            break;
          }
          int n = determineConsecutiveDigitCount(input, p);
          if (n >= 13) {
            sb.append((char) LATCH_TO_NUMERIC);
            encodingMode = NUMERIC_COMPACTION;
            textSubMode = SUBMODE_ALPHA; //Reset after latch
            encodeNumeric(input, p, n, sb);
            p += n;
          } else {
            int t = determineConsecutiveTextCount(input, p);
            if (t >= 5 || n == len) {
              if (encodingMode != TEXT_COMPACTION) {
                sb.append((char) LATCH_TO_TEXT);
                encodingMode = TEXT_COMPACTION;
                textSubMode = SUBMODE_ALPHA; //start with submode alpha after latch
              }
              textSubMode = encodeText(input, p, t, sb, textSubMode);
              p += t;
            } else {
              int b = determineConsecutiveBinaryCount(input, p, autoECI ? null : encoding);
              if (b == 0) {
                b = 1;
              }
              byte[] bytes = autoECI ? null : input.subSequence(p, p + b).toString().getBytes(encoding);
              if (((bytes == null && b == 1) || (bytes != null && bytes.length == 1))
                  && encodingMode == TEXT_COMPACTION) {
                //Switch for one byte (instead of latch)
                if (autoECI) {
                  encodeMultiECIBinary(input, p, 1, TEXT_COMPACTION, sb);
                } else {
                  encodeBinary(bytes, 0, 1, TEXT_COMPACTION, sb);
                }
              } else {
                //Mode latch performed by encodeBinary()
                if (autoECI) {
                  encodeMultiECIBinary(input, p, p + b, encodingMode, sb);
                } else {
                  encodeBinary(bytes, 0, bytes.length, encodingMode, sb);
                }
                encodingMode = BYTE_COMPACTION;
                textSubMode = SUBMODE_ALPHA; //Reset after latch
              }
              p += b;
            }
          }
        }
        break;
    }

    return sb.toString();
  }
