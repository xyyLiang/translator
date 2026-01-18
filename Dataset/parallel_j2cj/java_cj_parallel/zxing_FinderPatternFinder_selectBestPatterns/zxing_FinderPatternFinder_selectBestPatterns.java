  private FinderPattern[] selectBestPatterns() throws NotFoundException {

    int startSize = possibleCenters.size();
    if (startSize < 3) {
      // Couldn't find enough finder patterns
      throw NotFoundException.getNotFoundInstance();
    }

    for (Iterator<FinderPattern> it = possibleCenters.iterator(); it.hasNext();) {
      if (it.next().getCount() < CENTER_QUORUM) {
        it.remove();
      }
    }
