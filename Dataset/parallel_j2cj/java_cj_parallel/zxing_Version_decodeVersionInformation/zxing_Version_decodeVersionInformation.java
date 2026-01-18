  static Version decodeVersionInformation(int versionBits) {
    int bestDifference = Integer.MAX_VALUE;
    int bestVersion = 0;
    for (int i = 0; i < VERSION_DECODE_INFO.length; i++) {
      int targetVersion = VERSION_DECODE_INFO[i];
      // Do the version info bits match exactly? done.
      if (targetVersion == versionBits) {
        return getVersionForNumber(i + 7);
      }
      // Otherwise see if this is the closest to a real version info bit string
      // we have seen so far
      int bitsDifference = FormatInformation.numBitsDiffering(versionBits, targetVersion);
      if (bitsDifference < bestDifference) {
        bestVersion = i + 7;
        bestDifference = bitsDifference;
      }
    }
    // We can tolerate up to 3 bits of error since no two version info codewords will
    // differ in less than 8 bits.
    if (bestDifference <= 3) {
      return getVersionForNumber(bestVersion);
    }
    // If we didn't find a close enough match, fail
    return null;
  }
