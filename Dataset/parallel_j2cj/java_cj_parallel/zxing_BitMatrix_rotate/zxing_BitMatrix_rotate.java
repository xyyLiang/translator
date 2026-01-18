  public void rotate(int degrees) {
    switch (degrees % 360) {
      case 0:
        return;
      case 90:
        rotate90();
        return;
      case 180:
        rotate180();
        return;
      case 270:
        rotate90();
        rotate180();
        return;
    }
    throw new IllegalArgumentException("degrees must be a multiple of 0, 90, 180, or 270");
  }