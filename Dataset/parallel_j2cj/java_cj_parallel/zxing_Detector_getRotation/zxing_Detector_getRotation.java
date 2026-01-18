  private static int getRotation(int[] sides, int length) throws NotFoundException {
    int cornerBits = 0;
    for (int side : sides) {
      // XX......X where X's are orientation marks
      int t = ((side >> (length - 2)) << 1) + (side & 1);
      cornerBits = (cornerBits << 3) + t;
    }
    cornerBits = ((cornerBits & 1) << 11) + (cornerBits >> 1);
    for (int shift = 0; shift < 4; shift++) {
      if (Integer.bitCount(cornerBits ^ EXPECTED_CORNER_BITS[shift]) <= 2) {
        return shift;
      }
    }
    throw NotFoundException.getNotFoundInstance();
  }