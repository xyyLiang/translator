  private static void drawModeMessage(BitMatrix matrix, boolean compact, int matrixSize, BitArray modeMessage) {
    int center = matrixSize / 2;
    if (compact) {
      for (int i = 0; i < 7; i++) {
        int offset = center - 3 + i;
        if (modeMessage.get(i)) {
          matrix.set(offset, center - 5);
        }
        if (modeMessage.get(i + 7)) {
          matrix.set(center + 5, offset);
        }
        if (modeMessage.get(20 - i)) {
          matrix.set(offset, center + 5);
        }
        if (modeMessage.get(27 - i)) {
          matrix.set(center - 5, offset);
        }
      }
    } else {
      for (int i = 0; i < 10; i++) {
        int offset = center - 5 + i + i / 5;
        if (modeMessage.get(i)) {
          matrix.set(offset, center - 7);
        }
        if (modeMessage.get(i + 10)) {
          matrix.set(center + 7, offset);
        }
        if (modeMessage.get(29 - i)) {
          matrix.set(offset, center + 7);
        }
        if (modeMessage.get(39 - i)) {
          matrix.set(center - 7, offset);
        }
      }
    }
  }