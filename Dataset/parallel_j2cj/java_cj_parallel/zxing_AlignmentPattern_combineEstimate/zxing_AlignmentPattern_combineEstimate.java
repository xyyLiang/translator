  AlignmentPattern combineEstimate(float i, float j, float newModuleSize) {
    float combinedX = (getX() + j) / 2.0f;
    float combinedY = (getY() + i) / 2.0f;
    float combinedModuleSize = (estimatedModuleSize + newModuleSize) / 2.0f;
    return new AlignmentPattern(combinedX, combinedY, combinedModuleSize);
  }