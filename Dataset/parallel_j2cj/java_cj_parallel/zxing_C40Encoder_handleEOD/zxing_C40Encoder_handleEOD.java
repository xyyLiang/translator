  void handleEOD(EncoderContext context, StringBuilder buffer) {
    int unwritten = (buffer.length() / 3) * 2;
    int rest = buffer.length() % 3;

    int curCodewordCount = context.getCodewordCount() + unwritten;
    context.updateSymbolInfo(curCodewordCount);
    int available = context.getSymbolInfo().getDataCapacity() - curCodewordCount;

    if (rest == 2) {
      buffer.append('\0'); //Shift 1
      while (buffer.length() >= 3) {
        writeNextTriplet(context, buffer);
      }
      if (context.hasMoreCharacters()) {
        context.writeCodeword(HighLevelEncoder.C40_UNLATCH);
      }
    } else if (available == 1 && rest == 1) {
      while (buffer.length() >= 3) {
        writeNextTriplet(context, buffer);
      }
      if (context.hasMoreCharacters()) {
        context.writeCodeword(HighLevelEncoder.C40_UNLATCH);
      }
      // else no unlatch
      context.pos--;
    } else if (rest == 0) {
      while (buffer.length() >= 3) {
        writeNextTriplet(context, buffer);
      }
      if (available > 0 || context.hasMoreCharacters()) {
        context.writeCodeword(HighLevelEncoder.C40_UNLATCH);
      }
    } else {
      throw new IllegalStateException("Unexpected case. Please report!");
    }
    context.signalEncoderChange(HighLevelEncoder.ASCII_ENCODATION);
  }
