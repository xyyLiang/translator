  ModulusPoly negative() {
    int size = coefficients.length;
    int[] negativeCoefficients = new int[size];
    for (int i = 0; i < size; i++) {
      negativeCoefficients[i] = field.subtract(0, coefficients[i]);
    }
    return new ModulusPoly(field, negativeCoefficients);
  }
