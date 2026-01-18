  private static int moduleSize(int[] leftTopBlack, BitMatrix image) throws NotFoundException {
    int width = image.getWidth();
    int x = leftTopBlack[0];
    int y = leftTopBlack[1];
    while (x < width && image.get(x, y)) {
      x++;
    }
    if (x == width) {
      throw NotFoundException.getNotFoundInstance();
    }

    int moduleSize = x - leftTopBlack[0];
    if (moduleSize == 0) {
      throw NotFoundException.getNotFoundInstance();
    }
    return moduleSize;
  }