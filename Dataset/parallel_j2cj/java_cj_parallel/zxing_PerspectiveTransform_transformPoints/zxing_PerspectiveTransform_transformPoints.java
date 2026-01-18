  public void transformPoints(float[] points) {
    float a11 = this.a11;
    float a12 = this.a12;
    float a13 = this.a13;
    float a21 = this.a21;
    float a22 = this.a22;
    float a23 = this.a23;
    float a31 = this.a31;
    float a32 = this.a32;
    float a33 = this.a33;
    int maxI = points.length - 1; // points.length must be even
    for (int i = 0; i < maxI; i += 2) {
      float x = points[i];
      float y = points[i + 1];
      float denominator = a13 * x + a23 * y + a33;
      points[i] = (a11 * x + a21 * y + a31) / denominator;
      points[i + 1] = (a12 * x + a22 * y + a32) / denominator;
    }
  }
