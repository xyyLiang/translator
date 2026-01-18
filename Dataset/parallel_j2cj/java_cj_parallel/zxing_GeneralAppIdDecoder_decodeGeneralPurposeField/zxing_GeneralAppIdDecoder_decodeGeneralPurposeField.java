  DecodedInformation decodeGeneralPurposeField(int pos, String remaining) throws FormatException {
    this.buffer.setLength(0);

    if (remaining != null) {
      this.buffer.append(remaining);
    }

    this.current.setPosition(pos);

    DecodedInformation lastDecoded = parseBlocks();
    if (lastDecoded != null && lastDecoded.isRemaining()) {
      return new DecodedInformation(this.current.getPosition(),
        this.buffer.toString(), lastDecoded.getRemainingValue());
    }
    return new DecodedInformation(this.current.getPosition(), this.buffer.toString());
  }
