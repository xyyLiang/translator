  private boolean isValid(ResultPoint point) {
    int x = MathUtils.round(point.getX());
    int y = MathUtils.round(point.getY());
    return isValid(x, y);
  }