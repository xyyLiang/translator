  private DecodedNumeric decodeNumeric(int pos) throws FormatException {
    if (pos + 7 > this.information.getSize()) {
      int numeric = extractNumericValueFromBitArray(pos, 4);
      if (numeric == 0) {
        return new DecodedNumeric(this.information.getSize(), DecodedNumeric.FNC1, DecodedNumeric.FNC1);
      }
      return new DecodedNumeric(this.information.getSize(), numeric - 1, DecodedNumeric.FNC1);
    }
    int numeric = extractNumericValueFromBitArray(pos, 7);

    int digit1  = (numeric - 8) / 11;
    int digit2  = (numeric - 8) % 11;

    return new DecodedNumeric(pos + 7, digit1, digit2);
  }
