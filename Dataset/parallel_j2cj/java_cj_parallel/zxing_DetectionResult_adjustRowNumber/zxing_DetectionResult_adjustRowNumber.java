  private static boolean adjustRowNumber(Codeword codeword, Codeword otherCodeword) {
    if (otherCodeword == null) {
      return false;
    }
    if (otherCodeword.hasValidRowNumber() && otherCodeword.getBucket() == codeword.getBucket()) {
      codeword.setRowNumber(otherCodeword.getRowNumber());
      return true;
    }
    return false;
  }