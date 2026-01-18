  private static ResultPoint[] expandSquare(ResultPoint[] cornerPoints, int oldSide, int newSide) {
    float ratio = newSide / (2.0f * oldSide);
    float dx = cornerPoints[0].getX() - cornerPoints[2].getX();
    float dy = cornerPoints[0].getY() - cornerPoints[2].getY();
    float centerx = (cornerPoints[0].getX() + cornerPoints[2].getX()) / 2.0f;
    float centery = (cornerPoints[0].getY() + cornerPoints[2].getY()) / 2.0f;

    ResultPoint result0 = new ResultPoint(centerx + ratio * dx, centery + ratio * dy);
    ResultPoint result2 = new ResultPoint(centerx - ratio * dx, centery - ratio * dy);

    dx = cornerPoints[1].getX() - cornerPoints[3].getX();
    dy = cornerPoints[1].getY() - cornerPoints[3].getY();
    centerx = (cornerPoints[1].getX() + cornerPoints[3].getX()) / 2.0f;
    centery = (cornerPoints[1].getY() + cornerPoints[3].getY()) / 2.0f;
    ResultPoint result1 = new ResultPoint(centerx + ratio * dx, centery + ratio * dy);
    ResultPoint result3 = new ResultPoint(centerx - ratio * dx, centery - ratio * dy);

    return new ResultPoint[]{result0, result1, result2, result3};
  }