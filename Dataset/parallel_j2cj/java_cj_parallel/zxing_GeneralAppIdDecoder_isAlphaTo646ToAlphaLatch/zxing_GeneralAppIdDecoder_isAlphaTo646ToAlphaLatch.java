  private boolean isAlphaTo646ToAlphaLatch(int pos) {
    if (pos + 1 > this.information.getSize()) {
      return false;
    }

    for (int i = 0; i < 5 && i + pos < this.information.getSize(); ++i) {
      if (i == 2) {
        if (!this.information.get(pos + 2)) {
          return false;
        }
      } else if (this.information.get(pos + i)) {
        return false;
      }
    }

    return true;
  }
