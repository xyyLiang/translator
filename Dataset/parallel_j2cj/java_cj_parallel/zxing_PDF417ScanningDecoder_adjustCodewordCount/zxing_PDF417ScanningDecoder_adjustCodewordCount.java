  private static void adjustCodewordCount(DetectionResult detectionResult, BarcodeValue[][] barcodeMatrix)
      throws NotFoundException {
    BarcodeValue barcodeMatrix01 = barcodeMatrix[0][1];
    int[] numberOfCodewords = barcodeMatrix01.getValue();
    int calculatedNumberOfCodewords = detectionResult.getBarcodeColumnCount() *
        detectionResult.getBarcodeRowCount() -
        getNumberOfECCodeWords(detectionResult.getBarcodeECLevel());
    if (numberOfCodewords.length == 0) {
      if (calculatedNumberOfCodewords < 1 || calculatedNumberOfCodewords > PDF417Common.MAX_CODEWORDS_IN_BARCODE) {
        throw NotFoundException.getNotFoundInstance();
      }
      barcodeMatrix01.setValue(calculatedNumberOfCodewords);
    } else if (numberOfCodewords[0] != calculatedNumberOfCodewords &&
        calculatedNumberOfCodewords >= 1 &&
        calculatedNumberOfCodewords <= PDF417Common.MAX_CODEWORDS_IN_BARCODE) {
      // The calculated one is more reliable as it is derived from the row indicator columns
      barcodeMatrix01.setValue(calculatedNumberOfCodewords);
    }
  }
