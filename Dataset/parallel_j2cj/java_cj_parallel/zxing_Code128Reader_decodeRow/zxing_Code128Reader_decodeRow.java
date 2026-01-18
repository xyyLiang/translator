  @Override
  public Result decodeRow(int rowNumber, BitArray row, Map<DecodeHintType,?> hints)
      throws NotFoundException, FormatException, ChecksumException {

    boolean convertFNC1 = hints != null && hints.containsKey(DecodeHintType.ASSUME_GS1);

    int symbologyModifier = 0;

    int[] startPatternInfo = findStartPattern(row);
    int startCode = startPatternInfo[2];

    List<Byte> rawCodes = new ArrayList<>(20);
    rawCodes.add((byte) startCode);

    int codeSet;
    switch (startCode) {
      case CODE_START_A:
        codeSet = CODE_CODE_A;
        break;
      case CODE_START_B:
        codeSet = CODE_CODE_B;
        break;
      case CODE_START_C:
        codeSet = CODE_CODE_C;
        break;
      default:
        throw FormatException.getFormatInstance();
    }
