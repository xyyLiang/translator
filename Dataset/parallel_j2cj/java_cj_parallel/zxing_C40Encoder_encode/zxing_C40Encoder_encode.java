  @Override
  public void encode(EncoderContext context) {
    //step C
    StringBuilder buffer = new StringBuilder();
    while (context.hasMoreCharacters()) {
      char c = context.getCurrentChar();
      context.pos++;

      int lastCharSize = encodeChar(c, buffer);

      int unwritten = (buffer.length() / 3) * 2;

      int curCodewordCount = context.getCodewordCount() + unwritten;
      context.updateSymbolInfo(curCodewordCount);
      int available = context.getSymbolInfo().getDataCapacity() - curCodewordCount;

      if (!context.hasMoreCharacters()) {
        //Avoid having a single C40 value in the last triplet
        StringBuilder removed = new StringBuilder();
        if ((buffer.length() % 3) == 2 && available != 2) {
          lastCharSize = backtrackOneCharacter(context, buffer, removed, lastCharSize);
        }
        while ((buffer.length() % 3) == 1 && (lastCharSize > 3 || available != 1)) {
          lastCharSize = backtrackOneCharacter(context, buffer, removed, lastCharSize);
        }
        break;
      }

      int count = buffer.length();
      if ((count % 3) == 0) {
        int newMode = HighLevelEncoder.lookAheadTest(context.getMessage(), context.pos, getEncodingMode());
        if (newMode != getEncodingMode()) {
          // Return to ASCII encodation, which will actually handle latch to new mode
          context.signalEncoderChange(HighLevelEncoder.ASCII_ENCODATION);
          break;
        }
      }
    }
    handleEOD(context, buffer);
  }
