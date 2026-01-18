  private int adjustRowNumbers() {
    int unadjustedCount = adjustRowNumbersByRow();
    if (unadjustedCount == 0) {
      return 0;
    }
    for (int barcodeColumn = 1; barcodeColumn < barcodeColumnCount + 1; barcodeColumn++) {
      Codeword[] codewords = detectionResultColumns[barcodeColumn].getCodewords();
      for (int codewordsRow = 0; codewordsRow < codewords.length; codewordsRow++) {
        if (codewords[codewordsRow] == null) {
          continue;
        }
        if (!codewords[codewordsRow].hasValidRowNumber()) {
          adjustRowNumbers(barcodeColumn, codewordsRow, codewords);
        }
      }
    }
    return unadjustedCount;
  }