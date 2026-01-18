  private static String createECCBlock(CharSequence codewords, int numECWords) {
    int table = -1;
    for (int i = 0; i < FACTOR_SETS.length; i++) {
      if (FACTOR_SETS[i] == numECWords) {
        table = i;
        break;
      }
    }
    if (table < 0) {
      throw new IllegalArgumentException(
          "Illegal number of error correction codewords specified: " + numECWords);
    }
    int[] poly = FACTORS[table];
    char[] ecc = new char[numECWords];
    for (int i = 0; i < numECWords; i++) {
      ecc[i] = 0;
    }
    for (int i = 0; i < codewords.length(); i++) {
      int m = ecc[numECWords - 1] ^ codewords.charAt(i);
      for (int k = numECWords - 1; k > 0; k--) {
        if (m != 0 && poly[k] != 0) {
          ecc[k] = (char) (ecc[k - 1] ^ ALOG[(LOG[m] + LOG[poly[k]]) % 255]);
        } else {
          ecc[k] = ecc[k - 1];
        }
      }
      if (m != 0 && poly[0] != 0) {
        ecc[0] = (char) ALOG[(LOG[m] + LOG[poly[0]]) % 255];
      } else {
        ecc[0] = 0;
      }
    }
    char[] eccReversed = new char[numECWords];
    for (int i = 0; i < numECWords; i++) {
      eccReversed[i] = ecc[numECWords - i - 1];
    }
    return String.valueOf(eccReversed);
  }
