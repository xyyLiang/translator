  private ResultPoint getBlackPointOnSegment(float aX, float aY, float bX, float bY) {
    int dist = MathUtils.round(MathUtils.distance(aX, aY, bX, bY));
    float xStep = (bX - aX) / dist;
    float yStep = (bY - aY) / dist;

    for (int i = 0; i < dist; i++) {
      int x = MathUtils.round(aX + i * xStep);
      int y = MathUtils.round(aY + i * yStep);
      if (image.get(x, y)) {
        return new ResultPoint(x, y);
      }
    }
    return null;
  }