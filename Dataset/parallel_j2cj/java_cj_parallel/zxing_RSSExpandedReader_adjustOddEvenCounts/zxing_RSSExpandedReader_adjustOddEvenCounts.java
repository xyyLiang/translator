  private void adjustOddEvenCounts(int numModules) throws NotFoundException {

    int oddSum = MathUtils.sum(this.getOddCounts());
    int evenSum = MathUtils.sum(this.getEvenCounts());

    boolean incrementOdd = false;
    boolean decrementOdd = false;

    if (oddSum > 13) {
      decrementOdd = true;
    } else if (oddSum < 4) {
      incrementOdd = true;
    }
    boolean incrementEven = false;
    boolean decrementEven = false;
    if (evenSum > 13) {
      decrementEven = true;
    } else if (evenSum < 4) {
      incrementEven = true;
    }

    int mismatch = oddSum + evenSum - numModules;
    boolean oddParityBad = (oddSum & 0x01) == 1;
    boolean evenParityBad = (evenSum & 0x01) == 0;
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
      increment(this.getOddCounts(), this.getOddRoundingErrors());
    }
    if (decrementOdd) {
      decrement(this.getOddCounts(), this.getOddRoundingErrors());
    }
    if (incrementEven) {
      if (decrementEven) {
        throw NotFoundException.getNotFoundInstance();
      }
      increment(this.getEvenCounts(), this.getOddRoundingErrors());
    }
    if (decrementEven) {
      decrement(this.getEvenCounts(), this.getEvenRoundingErrors());
    }
  }
