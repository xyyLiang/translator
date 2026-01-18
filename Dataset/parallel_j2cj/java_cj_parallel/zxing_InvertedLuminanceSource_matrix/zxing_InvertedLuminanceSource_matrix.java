  @Override
  public byte[] getMatrix() {
    byte[] matrix = delegate.getMatrix();
    int length = getWidth() * getHeight();
    byte[] invertedMatrix = new byte[length];
    for (int i = 0; i < length; i++) {
      invertedMatrix[i] = (byte) (255 - (matrix[i] & 0xFF));
    }
    return invertedMatrix;
  }