  private static DetectionResult merge(DetectionResultRowIndicatorColumn leftRowIndicatorColumn,
                                       DetectionResultRowIndicatorColumn rightRowIndicatorColumn)
      throws NotFoundException {
    if (leftRowIndicatorColumn == null && rightRowIndicatorColumn == null) {
      return null;
    }
    BarcodeMetadata barcodeMetadata = getBarcodeMetadata(leftRowIndicatorColumn, rightRowIndicatorColumn);
    if (barcodeMetadata == null) {
      return null;
    }
    BoundingBox boundingBox = BoundingBox.merge(adjustBoundingBox(leftRowIndicatorColumn),
        adjustBoundingBox(rightRowIndicatorColumn));
    return new DetectionResult(barcodeMetadata, boundingBox);
  }