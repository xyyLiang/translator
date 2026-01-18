  final void encodeCompressedGtinWithoutAI(StringBuilder buf, int currentPos, int initialBufferPosition) {
    for (int i = 0; i < 4; ++i) {
      int currentBlock = this.getGeneralDecoder().extractNumericValueFromBitArray(currentPos + 10 * i, 10);
      if (currentBlock / 100 == 0) {
        buf.append('0');
      }
      if (currentBlock / 10 == 0) {
        buf.append('0');
      }
      buf.append(currentBlock);
    }

    appendCheckDigit(buf, initialBufferPosition);
  }