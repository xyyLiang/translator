  void remask() {
    if (parsedFormatInfo == null) {
      return; // We have no format information, and have no data mask
    }
    DataMask dataMask = DataMask.values()[parsedFormatInfo.getDataMask()];
    int dimension = bitMatrix.getHeight();
    dataMask.unmaskBitMatrix(bitMatrix, dimension);
  }
