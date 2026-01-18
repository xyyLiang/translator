  public static String encodeHighLevel(String msg,
                                       SymbolShapeHint shape,
                                       Dimension minSize,
                                       Dimension maxSize,
                                       boolean forceC40) {
    //the codewords 0..255 are encoded as Unicode characters
    C40Encoder c40Encoder = new C40Encoder();
    Encoder[] encoders = {
        new ASCIIEncoder(), c40Encoder, new TextEncoder(),
        new X12Encoder(), new EdifactEncoder(),  new Base256Encoder()
    };

    EncoderContext context = new EncoderContext(msg);
    context.setSymbolShape(shape);
    context.setSizeConstraints(minSize, maxSize);

    if (msg.startsWith(MACRO_05_HEADER) && msg.endsWith(MACRO_TRAILER)) {
      context.writeCodeword(MACRO_05);
      context.setSkipAtEnd(2);
      context.pos += MACRO_05_HEADER.length();
    } else if (msg.startsWith(MACRO_06_HEADER) && msg.endsWith(MACRO_TRAILER)) {
      context.writeCodeword(MACRO_06);
      context.setSkipAtEnd(2);
      context.pos += MACRO_06_HEADER.length();
    }

    int encodingMode = ASCII_ENCODATION; //Default mode

    if (forceC40) {
      c40Encoder.encodeMaximal(context);
      encodingMode = context.getNewEncoding();
      context.resetEncoderSignal();
    }

    while (context.hasMoreCharacters()) {
      encoders[encodingMode].encode(context);
      if (context.getNewEncoding() >= 0) {
        encodingMode = context.getNewEncoding();
        context.resetEncoderSignal();
      }
    }
    int len = context.getCodewordCount();
    context.updateSymbolInfo();
    int capacity = context.getSymbolInfo().getDataCapacity();
    if (len < capacity &&
        encodingMode != ASCII_ENCODATION &&
        encodingMode != BASE256_ENCODATION &&
        encodingMode != EDIFACT_ENCODATION) {
      context.writeCodeword('\u00fe'); //Unlatch (254)
    }
    //Padding
    StringBuilder codewords = context.getCodewords();
    if (codewords.length() < capacity) {
      codewords.append(PAD);
    }
    while (codewords.length() < capacity) {
      codewords.append(randomize253State(codewords.length() + 1));
    }

    return context.getCodewords().toString();
  }
