  private static BitMatrix applyRotation(BitMatrix matrix, int rotation) {
    if (rotation % 360 == 0) {
      return matrix;
    }

    BitMatrix newMatrix = matrix.clone();
    newMatrix.rotate(rotation);
    return newMatrix;
  }