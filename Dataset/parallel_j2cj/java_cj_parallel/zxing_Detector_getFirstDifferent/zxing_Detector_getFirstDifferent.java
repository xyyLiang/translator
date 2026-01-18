  private Point getFirstDifferent(Point init, boolean color, int dx, int dy) {
    int x = init.getX() + dx;
    int y = init.getY() + dy;

    while (isValid(x, y) && image.get(x, y) == color) {
      x += dx;
      y += dy;
    }

    x -= dx;
    y -= dy;

    while (isValid(x, y) && image.get(x, y) == color) {
      x += dx;
    }
    x -= dx;

    while (isValid(x, y) && image.get(x, y) == color) {
      y += dy;
    }
    y -= dy;

    return new Point(x, y);
  }