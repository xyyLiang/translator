  private CorrectedBitsResult correctBits(boolean[] rawbits) throws FormatException {
    GenericGF gf;
    int codewordSize;

    if (ddata.getNbLayers() <= 2) {
      codewordSize = 6;
      gf = GenericGF.AZTEC_DATA_6;
    } else if (ddata.getNbLayers() <= 8) {
      codewordSize = 8;
      gf = GenericGF.AZTEC_DATA_8;
    } else if (ddata.getNbLayers() <= 22) {
      codewordSize = 10;
      gf = GenericGF.AZTEC_DATA_10;
    } else {
      codewordSize = 12;
      gf = GenericGF.AZTEC_DATA_12;
    }

    int numDataCodewords = ddata.getNbDatablocks();
    int numCodewords = rawbits.length / codewordSize;
    if (numCodewords < numDataCodewords) {
      throw FormatException.getFormatInstance();
    }
    int offset = rawbits.length % codewordSize;

    int[] dataWords = new int[numCodewords];
    for (int i = 0; i < numCodewords; i++, offset += codewordSize) {
      dataWords[i] = readCode(rawbits, offset, codewordSize);
    }

    int errorsCorrected = 0;
    try {
      ReedSolomonDecoder rsDecoder = new ReedSolomonDecoder(gf);
      errorsCorrected = rsDecoder.decodeWithECCount(dataWords, numCodewords - numDataCodewords);
    } catch (ReedSolomonException ex) {
      throw FormatException.getFormatInstance(ex);
    }

    // Now perform the unstuffing operation.
    // First, count how many bits are going to be thrown out as stuffing
    int mask = (1 << codewordSize) - 1;
    int stuffedBits = 0;
    for (int i = 0; i < numDataCodewords; i++) {
      int dataWord = dataWords[i];
      if (dataWord == 0 || dataWord == mask) {
        throw FormatException.getFormatInstance();
      } else if (dataWord == 1 || dataWord == mask - 1) {
        stuffedBits++;
      }
    }
    // Now, actually unpack the bits and remove the stuffing
    boolean[] correctedBits = new boolean[numDataCodewords * codewordSize - stuffedBits];
    int index = 0;
    for (int i = 0; i < numDataCodewords; i++) {
      int dataWord = dataWords[i];
      if (dataWord == 1 || dataWord == mask - 1) {
        // next codewordSize-1 bits are all zeros or all ones
        Arrays.fill(correctedBits, index, index + codewordSize - 1, dataWord > 1);
        index += codewordSize - 1;
      } else {
        for (int bit = codewordSize - 1; bit >= 0; --bit) {
          correctedBits[index++] = (dataWord & (1 << bit)) != 0;
        }
      }
    }

    int ecLevel = 100 * (numCodewords - numDataCodewords) / numCodewords;
    return new CorrectedBitsResult(correctedBits, errorsCorrected, ecLevel);
  }
