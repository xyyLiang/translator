  void mirror() {
    for (int x = 0; x < bitMatrix.getWidth(); x++) {
      for (int y = x + 1; y < bitMatrix.getHeight(); y++) {
        if (bitMatrix.get(x, y) != bitMatrix.get(y, x)) {
          bitMatrix.flip(y, x);
          bitMatrix.flip(x, y);
        }
      }
    }
  }