  AlignmentPattern find() throws NotFoundException {
    int startX = this.startX;
    int height = this.height;
    int maxJ = startX + width;
    int middleI = startY + (height / 2);
    // We are looking for black/white/black modules in 1:1:1 ratio;
    // this tracks the number of black/white/black modules seen so far
    int[] stateCount = new int[3];
    for (int iGen = 0; iGen < height; iGen++) {
      // Search from middle outwards
      int i = middleI + ((iGen & 0x01) == 0 ? (iGen + 1) / 2 : -((iGen + 1) / 2));
      stateCount[0] = 0;
      stateCount[1] = 0;
      stateCount[2] = 0;
      int j = startX;
      // Burn off leading white pixels before anything else; if we start in the middle of
      // a white run, it doesn't make sense to count its length, since we don't know if the
      // white run continued to the left of the start point
      while (j < maxJ && !image.get(j, i)) {
        j++;
      }
      int currentState = 0;
      while (j < maxJ) {
        if (image.get(j, i)) {
          // Black pixel
          if (currentState == 1) { // Counting black pixels
            stateCount[1]++;
          } else { // Counting white pixels
            if (currentState == 2) { // A winner?
              if (foundPatternCross(stateCount)) { // Yes
                AlignmentPattern confirmed = handlePossibleCenter(stateCount, i, j);
                if (confirmed != null) {
                  return confirmed;
                }
              }
              stateCount[0] = stateCount[2];
              stateCount[1] = 1;
              stateCount[2] = 0;
              currentState = 1;
            } else {
              stateCount[++currentState]++;
            }
          }
        } else { // White pixel
          if (currentState == 1) { // Counting black pixels
            currentState++;
          }
          stateCount[currentState]++;
        }
        j++;
      }
      if (foundPatternCross(stateCount)) {
        AlignmentPattern confirmed = handlePossibleCenter(stateCount, i, maxJ);
        if (confirmed != null) {
          return confirmed;
        }
      }

    }

    // Hmm, nothing we saw was observed and confirmed twice. If we had
    // any guess at all, return it.
    if (!possibleCenters.isEmpty()) {
      return possibleCenters.get(0);
    }

    throw NotFoundException.getNotFoundInstance();
  }
