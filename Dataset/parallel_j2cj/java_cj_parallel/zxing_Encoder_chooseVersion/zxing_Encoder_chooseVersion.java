  private static Version chooseVersion(int numInputBits, ErrorCorrectionLevel ecLevel) throws WriterException {
    for (int versionNum = 1; versionNum <= 40; versionNum++) {
      Version version = Version.getVersionForNumber(versionNum);
      if (willFit(numInputBits, version, ecLevel)) {
        return version;
      }
    }
    throw new WriterException("Data too big");
  }