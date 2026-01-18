  @Override
  public void encode(EncoderContext context) {
    StringBuilder buffer = new StringBuilder();
    buffer.append('\0'); //Initialize length field
    while (context.hasMoreCharacters()) {
      char c = context.getCurrentChar();
      buffer.append(c);

      context.pos++;

      int newMode = HighLevelEncoder.lookAheadTest(context.getMessage(), context.pos, getEncodingMode());
      if (newMode != getEncodingMode()) {
        // Return to ASCII encodation, which will actually handle latch to new mode
        context.signalEncoderChange(HighLevelEncoder.ASCII_ENCODATION);
        break;
      }
    }
    int dataCount = buffer.length() - 1;
    int lengthFieldSize = 1;
    int currentSize = context.getCodewordCount() + dataCount + lengthFieldSize;
    context.updateSymbolInfo(currentSize);
    boolean mustPad = (context.getSymbolInfo().getDataCapacity() - currentSize) > 0;
    if (context.hasMoreCharacters() || mustPad) {
      if (dataCount <= 249) {
        buffer.setCharAt(0, (char) dataCount);
      } else if (dataCount <= 1555) {
        buffer.setCharAt(0, (char) ((dataCount / 250) + 249));
        buffer.insert(1, (char) (dataCount % 250));
      } else {
        throw new IllegalStateException(
            "Message length not in valid ranges: " + dataCount);
      }
    }
    for (int i = 0, c = buffer.length(); i < c; i++) {
      context.writeCodeword(randomize255State(
          buffer.charAt(i), context.getCodewordCount() + 1));
    }
  }