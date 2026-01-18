  private static int calculateBitsNeeded(Mode mode,
                                         BitArray headerBits,
                                         BitArray dataBits,
                                         Version version) {
    return headerBits.getSize() + mode.getCharacterCountBits(version) + dataBits.getSize();
  }