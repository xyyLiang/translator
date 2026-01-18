  private int backtrackOneCharacter(EncoderContext context,
                                    StringBuilder buffer, StringBuilder removed, int lastCharSize) {
    int count = buffer.length();
    buffer.delete(count - lastCharSize, count);
    context.pos--;
    char c = context.getCurrentChar();
    lastCharSize = encodeChar(c, removed);
    context.resetSymbolInfo(); //Deal with possible reduction in symbol size
    return lastCharSize;
  }

  static void writeNextTriplet(EncoderContext context, StringBuilder buffer) {
    context.writeCodewords(encodeToCodewords(buffer));
    buffer.delete(0, 3);
  }
