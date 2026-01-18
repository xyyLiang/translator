  static BitArray generateModeMessage(boolean compact, int layers, int messageSizeInWords) {
    BitArray modeMessage = new BitArray();
    if (compact) {
      modeMessage.appendBits(layers - 1, 2);
      modeMessage.appendBits(messageSizeInWords - 1, 6);
      modeMessage = generateCheckWords(modeMessage, 28, 4);
    } else {
      modeMessage.appendBits(layers - 1, 5);
      modeMessage.appendBits(messageSizeInWords - 1, 11);
      modeMessage = generateCheckWords(modeMessage, 40, 4);
    }
    return modeMessage;
  }