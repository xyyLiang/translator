  private void validateQuietZone(BitArray row, int startPattern) throws NotFoundException {

    int quietCount = this.narrowLineWidth * 10;  // expect to find this many pixels of quiet zone

    // if there are not so many pixel at all let's try as many as possible
    quietCount = Math.min(quietCount, startPattern);

    for (int i = startPattern - 1; quietCount > 0 && i >= 0; i--) {
      if (row.get(i)) {
        break;
      }
      quietCount--;
    }
    if (quietCount != 0) {
      // Unable to find the necessary number of quiet zone pixels.
      throw NotFoundException.getNotFoundInstance();
    }
  }