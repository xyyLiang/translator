  public DecoderResult decode(AztecDetectorResult detectorResult) throws FormatException {
    ddata = detectorResult;
    BitMatrix matrix = detectorResult.getBits();
    boolean[] rawbits = extractBits(matrix);
    CorrectedBitsResult correctedBits = correctBits(rawbits);
    byte[] rawBytes = convertBoolArrayToByteArray(correctedBits.correctBits);
    String result = getEncodedData(correctedBits.correctBits);
    DecoderResult decoderResult =
        new DecoderResult(rawBytes, result, null, String.format("%d%%", correctedBits.ecLevel));
    decoderResult.setNumBits(correctedBits.correctBits.length);
    decoderResult.setErrorsCorrected(correctedBits.errorsCorrected);
    return decoderResult;
  }