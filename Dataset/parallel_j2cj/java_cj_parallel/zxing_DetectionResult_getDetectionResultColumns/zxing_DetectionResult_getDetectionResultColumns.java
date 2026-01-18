  DetectionResultColumn[] getDetectionResultColumns() {
    adjustIndicatorColumnRowNumbers(detectionResultColumns[0]);
    adjustIndicatorColumnRowNumbers(detectionResultColumns[barcodeColumnCount + 1]);
    int unadjustedCodewordCount = PDF417Common.MAX_CODEWORDS_IN_BARCODE;
    int previousUnadjustedCount;
    do {
      previousUnadjustedCount = unadjustedCodewordCount;
      unadjustedCodewordCount = adjustRowNumbers();
    } while (unadjustedCodewordCount > 0 && unadjustedCodewordCount < previousUnadjustedCount);
    return detectionResultColumns;
  }