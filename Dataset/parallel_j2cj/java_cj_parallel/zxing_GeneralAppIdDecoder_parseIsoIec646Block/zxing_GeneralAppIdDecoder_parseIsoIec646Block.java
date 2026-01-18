  private BlockParsedResult parseIsoIec646Block() throws FormatException {
    while (isStillIsoIec646(current.getPosition())) {
      DecodedChar iso = decodeIsoIec646(current.getPosition());
      current.setPosition(iso.getNewPosition());

      if (iso.isFNC1()) {
        DecodedInformation information = new DecodedInformation(current.getPosition(), buffer.toString());
        return new BlockParsedResult(information, true);
      }
      buffer.append(iso.getValue());
    }

    if (isAlphaOr646ToNumericLatch(current.getPosition())) {
      current.incrementPosition(3);
      current.setNumeric();
    } else if (isAlphaTo646ToAlphaLatch(current.getPosition())) {
      if (current.getPosition() + 5 < this.information.getSize()) {
        current.incrementPosition(5);
      } else {
        current.setPosition(this.information.getSize());
      }

      current.setAlpha();
    }
    return new BlockParsedResult();
  }
