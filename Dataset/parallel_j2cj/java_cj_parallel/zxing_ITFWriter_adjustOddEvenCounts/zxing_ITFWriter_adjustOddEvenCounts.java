  private void adjustOddEvenCounts(boolean outsideChar, int numModules) throws NotFoundException {

    int oddSum = MathUtils.sum(getOddCounts());
    int evenSum = MathUtils.sum(getEvenCounts());

    boolean incrementOdd = false;
    boolean decrementOdd = false;
    boolean incrementEven = false;
    boolean decrementEven = false;

    if (outsideChar) {
      if (oddSum > 12) {
        decrementOdd = true;
      } else if (oddSum < 4) {
        incrementOdd = true;
      }
      if (evenSum > 12) {
        decrementEven = true;
      } else if (evenSum < 4) {
        incrementEven = true;
      }
    } else {
      if (oddSum > 11) {
        decrementOdd = true;
      } else if (oddSum < 5) {
        incrementOdd = true;
      }
      if (evenSum > 10) {
        decrementEven = true;
      } else if (evenSum < 4) {
        incrementEven = true;
      }
    }

    int mismatch = oddSum + evenSum - numModules;
    boolean oddParityBad = (oddSum & 0x01) == (outsideChar ? 1 : 0);
    boolean evenParityBad = (evenSum & 0x01) == 1;
    /*if (mismatch == 2) {
      if (!(oddParityBad && evenParityBad)) {
        throw ReaderException.getInstance();
      }
      decrementOdd = true;
      decrementEven = true;
    } else if (mismatch == -2) {
      if (!(oddParityBad && evenParityBad)) {
        throw ReaderException.getInstance();
      }
      incrementOdd = true;
      incrementEven = true;
    } else */
    switch (mismatch) {
      case 1:
        if (oddParityBad) {
          if (evenParityBad) {
            throw NotFoundException.getNotFoundInstance();
          }
          decrementOdd = true;
        } else {
          if (!evenParityBad) {
            throw NotFoundException.getNotFoundInstance();
          }
          decrementEven = true;
        }
        break;
      case -1:
        if (oddParityBad) {
          if (evenParityBad) {
            throw NotFoundException.getNotFoundInstance();
          }
          incrementOdd = true;
        } else {
          if (!evenParityBad) {
            throw NotFoundException.getNotFoundInstance();
          }
          incrementEven = true;
        }
        break;
      case 0:
        if (oddParityBad) {
          if (!evenParityBad) {
            throw NotFoundException.getNotFoundInstance();
          }
          // Both bad
          if (oddSum < evenSum) {
            incrementOdd = true;
            decrementEven = true;
          } else {
            decrementOdd = true;
            incrementEven = true;
          }
        } else {
          if (evenParityBad) {
            throw NotFoundException.getNotFoundInstance();
          }
          // Nothing to do!
        }
        break;
      default:
        throw NotFoundException.getNotFoundInstance();
    }

    if (incrementOdd) {
      if (decrementOdd) {
        throw NotFoundException.getNotFoundInstance();
      }
      increment(getOddCounts(), getOddRoundingErrors());
    }
    if (decrementOdd) {
      decrement(getOddCounts(), getOddRoundingErrors());
    }
    if (incrementEven) {
      if (decrementEven) {
        throw NotFoundException.getNotFoundInstance();
      }
      increment(getEvenCounts(), getOddRoundingErrors());
    }
    if (decrementEven) {
      decrement(getEvenCounts(), getEvenRoundingErrors());
    }

  }
