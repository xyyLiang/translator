  private int sampleLine(ResultPoint p1, ResultPoint p2, int size) {
    int result = 0;

    float d = distance(p1, p2);
    float moduleSize = d / size;
    float px = p1.getX();
    float py = p1.getY();
    float dx = moduleSize * (p2.getX() - p1.getX()) / d;
    float dy = moduleSize * (p2.getY() - p1.getY()) / d;
    for (int i = 0; i < size; i++) {
      if (image.get(MathUtils.round(px + i * dx), MathUtils.round(py + i * dy))) {
        result |= 1 << (size - i - 1);
      }
    }
    return result;
  }