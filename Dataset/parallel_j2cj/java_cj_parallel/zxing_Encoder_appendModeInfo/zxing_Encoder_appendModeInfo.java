  static void appendModeInfo(Mode mode, BitArray bits) {
    bits.appendBits(mode.getBits(), 4);
  }