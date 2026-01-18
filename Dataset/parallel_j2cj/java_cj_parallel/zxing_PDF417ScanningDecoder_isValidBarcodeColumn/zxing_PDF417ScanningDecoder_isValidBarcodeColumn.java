  private static boolean isValidBarcodeColumn(DetectionResult detectionResult, int barcodeColumn) {
    return barcodeColumn >= 0 && barcodeColumn <= detectionResult.getBarcodeColumnCount() + 1;
  }