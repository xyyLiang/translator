 private void setEmphasis(int emphasis) throws InvalidDataException {
  switch (emphasis) {
   case 0:
    this.emphasis = EMPHASIS_NONE;
    break;
   case 1:
    this.emphasis = EMPHASIS__50_15_MS;
    break;
   case 3:
    this.emphasis = EMPHASIS_CCITT_J_17;
    break;
   default:
    throw new InvalidDataException("Invalid emphasis in frame header");
  }
 }