  public static DecoderResult decode(BitMatrix image,
                                     ResultPoint imageTopLeft,
                                     ResultPoint imageBottomLeft,
                                     ResultPoint imageTopRight,
                                     ResultPoint imageBottomRight,
                                     int minCodewordWidth,
                                     int maxCodewordWidth)
      throws NotFoundException, FormatException, ChecksumException {
    BoundingBox boundingBox = new BoundingBox(image, imageTopLeft, imageBottomLeft, imageTopRight, imageBottomRight);
    DetectionResultRowIndicatorColumn leftRowIndicatorColumn = null;
    DetectionResultRowIndicatorColumn rightRowIndicatorColumn = null;
    DetectionResult detectionResult;
    for (boolean firstPass = true; ; firstPass = false) {
      if (imageTopLeft != null) {
        leftRowIndicatorColumn = getRowIndicatorColumn(image, boundingBox, imageTopLeft, true, minCodewordWidth,
            maxCodewordWidth);
      }
      if (imageTopRight != null) {
        rightRowIndicatorColumn = getRowIndicatorColumn(image, boundingBox, imageTopRight, false, minCodewordWidth,
            maxCodewordWidth);
      }
      detectionResult = merge(leftRowIndicatorColumn, rightRowIndicatorColumn);
      if (detectionResult == null) {
        throw NotFoundException.getNotFoundInstance();
      }
      BoundingBox resultBox = detectionResult.getBoundingBox();
      if (firstPass && resultBox != null &&
          (resultBox.getMinY() < boundingBox.getMinY() || resultBox.getMaxY() > boundingBox.getMaxY())) {
        boundingBox = resultBox;
      } else {
        break;
      }
    }
    detectionResult.setBoundingBox(boundingBox);
    int maxBarcodeColumn = detectionResult.getBarcodeColumnCount() + 1;
    detectionResult.setDetectionResultColumn(0, leftRowIndicatorColumn);
    detectionResult.setDetectionResultColumn(maxBarcodeColumn, rightRowIndicatorColumn);

    boolean leftToRight = leftRowIndicatorColumn != null;
    for (int barcodeColumnCount = 1; barcodeColumnCount <= maxBarcodeColumn; barcodeColumnCount++) {
      int barcodeColumn = leftToRight ? barcodeColumnCount : maxBarcodeColumn - barcodeColumnCount;
      if (detectionResult.getDetectionResultColumn(barcodeColumn) != null) {
        // This will be the case for the opposite row indicator column, which doesn't need to be decoded again.
        continue;
      }
      DetectionResultColumn detectionResultColumn;
      if (barcodeColumn == 0 || barcodeColumn == maxBarcodeColumn) {
        detectionResultColumn = new DetectionResultRowIndicatorColumn(boundingBox, barcodeColumn == 0);
      } else {
        detectionResultColumn = new DetectionResultColumn(boundingBox);
      }
      detectionResult.setDetectionResultColumn(barcodeColumn, detectionResultColumn);
      int startColumn = -1;
      int previousStartColumn = startColumn;
      // TODO start at a row for which we know the start position, then detect upwards and downwards from there.
      for (int imageRow = boundingBox.getMinY(); imageRow <= boundingBox.getMaxY(); imageRow++) {
        startColumn = getStartColumn(detectionResult, barcodeColumn, imageRow, leftToRight);
        if (startColumn < 0 || startColumn > boundingBox.getMaxX()) {
          if (previousStartColumn == -1) {
            continue;
          }
          startColumn = previousStartColumn;
        }
        Codeword codeword = detectCodeword(image, boundingBox.getMinX(), boundingBox.getMaxX(), leftToRight,
            startColumn, imageRow, minCodewordWidth, maxCodewordWidth);
        if (codeword != null) {
          detectionResultColumn.setCodeword(imageRow, codeword);
          previousStartColumn = startColumn;
          minCodewordWidth = Math.min(minCodewordWidth, codeword.getWidth());
          maxCodewordWidth = Math.max(maxCodewordWidth, codeword.getWidth());
        }
      }
    }
    return createDecoderResult(detectionResult);
  }
