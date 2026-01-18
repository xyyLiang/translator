  private static double squaredDistance(FinderPattern a, FinderPattern b) {
    double x = a.getX() - b.getX();
    double y = a.getY() - b.getY();
    return x * x + y * y;
  }