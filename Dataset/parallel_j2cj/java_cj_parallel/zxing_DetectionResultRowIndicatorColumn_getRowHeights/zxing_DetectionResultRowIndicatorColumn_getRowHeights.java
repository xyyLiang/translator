  int[] getRowHeights() {
    BarcodeMetadata barcodeMetadata = getBarcodeMetadata();
    if (barcodeMetadata == null) {
      return null;
    }
    adjustIncompleteIndicatorColumnRowNumbers(barcodeMetadata);
    int[] result = new int[barcodeMetadata.getRowCount()];
    for (Codeword codeword : getCodewords()) {
      if (codeword != null) {
        int rowNumber = codeword.getRowNumber();
        if (rowNumber >= result.length) {
          // We have more rows than the barcode metadata allows for, ignore them.
          continue;
        }
        result[rowNumber]++;
      } // else throw exception?
    }
    return result;
  }