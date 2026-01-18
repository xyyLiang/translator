  private static void decodeHanziSegment(BitSource bits,
                                         StringBuilder result,
                                         int count) throws FormatException {
    if (StringUtils.GB2312_CHARSET == null) {
      // Not supported without charset support
      throw FormatException.getFormatInstance();
    }
    // Don't crash trying to read more bits than we have available.
    if (count * 13 > bits.available()) {
      throw FormatException.getFormatInstance();
    }

    // Each character will require 2 bytes. Read the characters as 2-byte pairs
    // and decode as GB2312 afterwards
    byte[] buffer = new byte[2 * count];
    int offset = 0;
    while (count > 0) {
      // Each 13 bits encodes a 2-byte character
      int twoBytes = bits.readBits(13);
      int assembledTwoBytes = ((twoBytes / 0x060) << 8) | (twoBytes % 0x060);
      if (assembledTwoBytes < 0x00A00) {
        // In the 0xA1A1 to 0xAAFE range
        assembledTwoBytes += 0x0A1A1;
      } else {
        // In the 0xB0A1 to 0xFAFE range
        assembledTwoBytes += 0x0A6A1;
      }
      buffer[offset] = (byte) ((assembledTwoBytes >> 8) & 0xFF);
      buffer[offset + 1] = (byte) (assembledTwoBytes & 0xFF);
      offset += 2;
      count--;
    }

    result.append(new String(buffer, StringUtils.GB2312_CHARSET));
  }
