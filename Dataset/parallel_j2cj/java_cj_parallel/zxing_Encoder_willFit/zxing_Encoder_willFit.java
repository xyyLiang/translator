  static boolean willFit(int numInputBits, Version version, ErrorCorrectionLevel ecLevel) {
    // In the following comments, we use numbers of Version 7-H.
    // numBytes = 196
    int numBytes = version.getTotalCodewords();
    // getNumECBytes = 130
    Version.ECBlocks ecBlocks = version.getECBlocksForLevel(ecLevel);
    int numEcBytes = ecBlocks.getTotalECCodewords();
    // getNumDataBytes = 196 - 130 = 66
    int numDataBytes = numBytes - numEcBytes;
    int totalInputBytes = (numInputBits + 7) / 8;
    return numDataBytes >= totalInputBytes;
  }
