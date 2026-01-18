  @Override
  void handleEOD(EncoderContext context, StringBuilder buffer) {
    context.updateSymbolInfo();
    int available = context.getSymbolInfo().getDataCapacity() - context.getCodewordCount();
    int count = buffer.length();
    context.pos -= count;
    if (context.getRemainingCharacters() > 1 || available > 1 ||
        context.getRemainingCharacters() != available) {
      context.writeCodeword(HighLevelEncoder.X12_UNLATCH);
    }
    if (context.getNewEncoding() < 0) {
      context.signalEncoderChange(HighLevelEncoder.ASCII_ENCODATION);
    }
  }