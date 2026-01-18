  private static int calculateBinaryShiftCost(int binaryShiftByteCount) {
    if (binaryShiftByteCount > 62) {
      return 21; // B/S with extended length
    }
    if (binaryShiftByteCount > 31) {
      return 20; // two B/S
    }
    if (binaryShiftByteCount > 0) {
      return 10; // one B/S
    }
    return 0;
  }