  static DecoderResult decode(byte[] bytes,
                              Version version,
                              ErrorCorrectionLevel ecLevel,
                              Map<DecodeHintType,?> hints) throws FormatException {
    BitSource bits = new BitSource(bytes);
    StringBuilder result = new StringBuilder(50);
    List<byte[]> byteSegments = new ArrayList<>(1);
    int symbolSequence = -1;
    int parityData = -1;
    int symbologyModifier;

    try {
      CharacterSetECI currentCharacterSetECI = null;
      boolean fc1InEffect = false;
      boolean hasFNC1first = false;
      boolean hasFNC1second = false;
      Mode mode;
      do {
        // While still another segment to read...
        if (bits.available() < 4) {
          // OK, assume we're done. Really, a TERMINATOR mode should have been recorded here
          mode = Mode.TERMINATOR;
        } else {
          mode = Mode.forBits(bits.readBits(4)); // mode is encoded by 4 bits
        }
        switch (mode) {
          case TERMINATOR:
            break;
          case FNC1_FIRST_POSITION:
            hasFNC1first = true; // symbology detection
            // We do little with FNC1 except alter the parsed result a bit according to the spec
            fc1InEffect = true;
            break;
          case FNC1_SECOND_POSITION:
            hasFNC1second = true; // symbology detection
            // We do little with FNC1 except alter the parsed result a bit according to the spec
            fc1InEffect = true;
            break;
          case STRUCTURED_APPEND:
            if (bits.available() < 16) {
              throw FormatException.getFormatInstance();
            }
            // sequence number and parity is added later to the result metadata
            // Read next 8 bits (symbol sequence #) and 8 bits (parity data), then continue
            symbolSequence = bits.readBits(8);
            parityData = bits.readBits(8);
            break;
          case ECI:
            // Count doesn't apply to ECI
            int value = parseECIValue(bits);
            currentCharacterSetECI = CharacterSetECI.getCharacterSetECIByValue(value);
            if (currentCharacterSetECI == null) {
              throw FormatException.getFormatInstance();
            }
            break;
          case HANZI:
            // First handle Hanzi mode which does not start with character count
            // Chinese mode contains a sub set indicator right after mode indicator
            int subset = bits.readBits(4);
            int countHanzi = bits.readBits(mode.getCharacterCountBits(version));
            if (subset == GB2312_SUBSET) {
              decodeHanziSegment(bits, result, countHanzi);
            }
            break;
          default:
            // "Normal" QR code modes:
            // How many characters will follow, encoded in this mode?
            int count = bits.readBits(mode.getCharacterCountBits(version));
            switch (mode) {
              case NUMERIC:
                decodeNumericSegment(bits, result, count);
                break;
              case ALPHANUMERIC:
                decodeAlphanumericSegment(bits, result, count, fc1InEffect);
                break;
              case BYTE:
                decodeByteSegment(bits, result, count, currentCharacterSetECI, byteSegments, hints);
                break;
              case KANJI:
                decodeKanjiSegment(bits, result, count);
                break;
              default:
                throw FormatException.getFormatInstance();
            }
            break;
        }
      } while (mode != Mode.TERMINATOR);

      if (currentCharacterSetECI != null) {
        if (hasFNC1first) {
          symbologyModifier = 4;
        } else if (hasFNC1second) {
          symbologyModifier = 6;
        } else {
          symbologyModifier = 2;
        }
      } else {
        if (hasFNC1first) {
          symbologyModifier = 3;
        } else if (hasFNC1second) {
          symbologyModifier = 5;
        } else {
          symbologyModifier = 1;
        }
      }

    } catch (IllegalArgumentException iae) {
      // from readBits() calls
      throw FormatException.getFormatInstance();
    }

    return new DecoderResult(bytes,
                             result.toString(),
                             byteSegments.isEmpty() ? null : byteSegments,
                             ecLevel == null ? null : ecLevel.toString(),
                             symbolSequence,
                             parityData,
                             symbologyModifier);
  }