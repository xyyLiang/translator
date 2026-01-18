  static void writeNextTriplet(EncoderContext context, StringBuilder buffer) {
    context.writeCodewords(encodeToCodewords(buffer));
    buffer.delete(0, 3);
  }