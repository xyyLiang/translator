  private static float crossProductZ(ResultPoint pointA,
                                     ResultPoint pointB,
                                     ResultPoint pointC) {
    float bX = pointB.x;
    float bY = pointB.y;
    return ((pointC.x - bX) * (pointA.y - bY)) - ((pointC.y - bY) * (pointA.x - bX));
  }