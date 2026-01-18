  private static Version recommendVersion(ErrorCorrectionLevel ecLevel,
                                          Mode mode,
                                          BitArray headerBits,
                                          BitArray dataBits) throws WriterException {
    // Hard part: need to know version to know how many bits length takes. But need to know how many
    // bits it takes to know version. First we take a guess at version by assuming version will be
    // the minimum, 1:
    int provisionalBitsNeeded = calculateBitsNeeded(mode, headerBits, dataBits, Version.getVersionForNumber(1));
    Version provisionalVersion = chooseVersion(provisionalBitsNeeded, ecLevel);

    // Use that guess to calculate the right version. I am still not sure this works in 100% of cases.
    int bitsNeeded = calculateBitsNeeded(mode, headerBits, dataBits, provisionalVersion);
    return chooseVersion(bitsNeeded, ecLevel);
  }
