  protected final boolean handlePossibleCenter(int[] stateCount, int i, int j) {
    int stateCountTotal = stateCount[0] + stateCount[1] + stateCount[2] + stateCount[3] +
        stateCount[4];
    float centerJ = centerFromEnd(stateCount, j);
    float centerI = crossCheckVertical(i, (int) centerJ, stateCount[2], stateCountTotal);
    if (!Float.isNaN(centerI)) {
      // Re-cross check
      centerJ = crossCheckHorizontal((int) centerJ, (int) centerI, stateCount[2], stateCountTotal);
      if (!Float.isNaN(centerJ) && crossCheckDiagonal((int) centerI, (int) centerJ)) {
        float estimatedModuleSize = stateCountTotal / 7.0f;
        boolean found = false;
        for (int index = 0; index < possibleCenters.size(); index++) {
          FinderPattern center = possibleCenters.get(index);
          // Look for about the same center and module size:
          if (center.aboutEquals(estimatedModuleSize, centerI, centerJ)) {
            possibleCenters.set(index, center.combineEstimate(centerI, centerJ, estimatedModuleSize));
            found = true;
            break;
          }
        }
        if (!found) {
          FinderPattern point = new FinderPattern(centerJ, centerI, estimatedModuleSize);
          possibleCenters.add(point);
          if (resultPointCallback != null) {
            resultPointCallback.foundPossibleResultPoint(point);
          }
        }
        return true;
      }
    }
    return false;
  }
