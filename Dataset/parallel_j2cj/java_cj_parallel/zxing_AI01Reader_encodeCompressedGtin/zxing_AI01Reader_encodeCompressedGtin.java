  final void encodeCompressedGtin(StringBuilder buf, int currentPos) {
    buf.append("(01)");
    int initialPosition = buf.length();
    buf.append('9');

    encodeCompressedGtinWithoutAI(buf, currentPos, initialPosition);
  }