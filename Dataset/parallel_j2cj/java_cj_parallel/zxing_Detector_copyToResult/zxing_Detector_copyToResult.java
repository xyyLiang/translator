  private static void copyToResult(ResultPoint[] result, ResultPoint[] tmpResult, int[] destinationIndexes) {
    for (int i = 0; i < destinationIndexes.length; i++) {
      result[destinationIndexes[i]] = tmpResult[i];
    }
  }