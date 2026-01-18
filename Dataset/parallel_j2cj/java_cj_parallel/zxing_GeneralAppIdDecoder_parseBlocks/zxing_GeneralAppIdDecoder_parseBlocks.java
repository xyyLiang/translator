  private DecodedInformation parseBlocks() throws FormatException {
    boolean isFinished;
    BlockParsedResult result;
    do {
      int initialPosition = current.getPosition();

      if (current.isAlpha()) {
        result = parseAlphaBlock();
        isFinished = result.isFinished();
      } else if (current.isIsoIec646()) {
        result = parseIsoIec646Block();
        isFinished = result.isFinished();
      } else { // it must be numeric
        result = parseNumericBlock();
        isFinished = result.isFinished();
      }

      boolean positionChanged = initialPosition != current.getPosition();
      if (!positionChanged && !isFinished) {
        break;
      }
    } while (!isFinished);

    return result.getDecodedInformation();
  }
