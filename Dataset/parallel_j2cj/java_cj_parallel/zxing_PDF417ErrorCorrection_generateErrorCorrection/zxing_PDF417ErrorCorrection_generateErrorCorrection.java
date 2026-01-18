  static String generateErrorCorrection(CharSequence dataCodewords, int errorCorrectionLevel) {
    int k = getErrorCorrectionCodewordCount(errorCorrectionLevel);
    char[] e = new char[k];
    int sld = dataCodewords.length();
    for (int i = 0; i < sld; i++) {
      int t1 = (dataCodewords.charAt(i) + e[e.length - 1]) % 929;
      int t2;
      int t3;
      for (int j = k - 1; j >= 1; j--) {
        t2 = (t1 * EC_COEFFICIENTS[errorCorrectionLevel][j]) % 929;
        t3 = 929 - t2;
        e[j] = (char) ((e[j - 1] + t3) % 929);
      }
      t2 = (t1 * EC_COEFFICIENTS[errorCorrectionLevel][0]) % 929;
      t3 = 929 - t2;
      e[0] = (char) (t3 % 929);
    }
    StringBuilder sb = new StringBuilder(k);
    for (int j = k - 1; j >= 0; j--) {
      if (e[j] != 0) {
        e[j] = (char) (929 - e[j]);
      }
      sb.append(e[j]);
    }
    return sb.toString();
  }
