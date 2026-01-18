  private void adjustIndicatorColumnRowNumbers(DetectionResultColumn detectionResultColumn) {
    if (detectionResultColumn != null) {
      ((DetectionResultRowIndicatorColumn) detectionResultColumn)
          .adjustCompleteIndicatorColumnRowNumbers(barcodeMetadata);
    }
  }