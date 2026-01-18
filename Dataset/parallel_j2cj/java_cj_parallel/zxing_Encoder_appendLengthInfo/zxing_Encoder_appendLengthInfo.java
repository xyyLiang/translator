  static void appendLengthInfo(int numLetters, Version version, Mode mode, BitArray bits) throws WriterException {
    int numBits = mode.getCharacterCountBits(version);
    if (numLetters >= (1 << numBits)) {
      throw new WriterException(numLetters + " is bigger than " + ((1 << numBits) - 1));
    }
    bits.appendBits(numLetters, numBits);
  }