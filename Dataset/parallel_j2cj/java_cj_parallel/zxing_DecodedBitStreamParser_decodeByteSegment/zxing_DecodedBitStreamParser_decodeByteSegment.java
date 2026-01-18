  private static void decodeByteSegment(BitSource bits,
                                        StringBuilder result,
                                        int count,
                                        CharacterSetECI currentCharacterSetECI,
                                        Collection<byte[]> byteSegments,
                                        Map<DecodeHintType,?> hints) throws FormatException {
    // Don't crash trying to read more bits than we have available.
    if (8 * count > bits.available()) {
      throw FormatException.getFormatInstance();
    }

    byte[] readBytes = new byte[count];
    for (int i = 0; i < count; i++) {
      readBytes[i] = (byte) bits.readBits(8);
    }
    Charset encoding;
    if (currentCharacterSetECI == null) {
      // The spec isn't clear on this mode; see
      // section 6.4.5: t does not say which encoding to assuming
      // upon decoding. I have seen ISO-8859-1 used as well as
      // Shift_JIS -- without anything like an ECI designator to
      // give a hint.
      encoding = StringUtils.guessCharset(readBytes, hints);
    } else {
      encoding = currentCharacterSetECI.getCharset();
    }
    result.append(new String(readBytes, encoding));
    byteSegments.add(readBytes);
  }
