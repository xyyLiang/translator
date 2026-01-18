  static int applyMaskPenaltyRule1(ByteMatrix matrix) {
    return applyMaskPenaltyRule1Internal(matrix, true) + applyMaskPenaltyRule1Internal(matrix, false);
  }