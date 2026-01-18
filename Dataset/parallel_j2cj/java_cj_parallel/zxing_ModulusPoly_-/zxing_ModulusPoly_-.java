  ModulusPoly subtract(ModulusPoly other) {
    if (!field.equals(other.field)) {
      throw new IllegalArgumentException("ModulusPolys do not have same ModulusGF field");
    }
    if (other.isZero()) {
      return this;
    }
    return add(other.negative());
  }
