  @Override
  public void encode(EncoderContext context) {
    //step F
    StringBuilder buffer = new StringBuilder();
    while (context.hasMoreCharacters()) {
      char c = context.getCurrentChar();
      encodeChar(c, buffer);
      context.pos++;

      int count = buffer.length();
      if (count >= 4) {
        context.writeCodewords(encodeToCodewords(buffer));
        buffer.delete(0, 4);

        int newMode = HighLevelEncoder.lookAheadTest(context.getMessage(), context.pos, getEncodingMode());
        if (newMode != getEncodingMode()) {
          // Return to ASCII encodation, which will actually handle latch to new mode
          context.signalEncoderChange(HighLevelEncoder.ASCII_ENCODATION);
          break;
        }
      }
    }
    buffer.append((char) 31); //Unlatch
    handleEOD(context, buffer);
  }
