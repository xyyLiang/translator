  private static String decodeBase900toBase10(int[] codewords, int count) throws FormatException {
    BigInteger result = BigInteger.ZERO;
    for (int i = 0; i < count; i++) {
      result = result.add(EXP900[count - i - 1].multiply(BigInteger.valueOf(codewords[i])));
    }
    String resultString = result.toString();
    if (resultString.charAt(0) != '1') {
      throw FormatException.getFormatInstance();
    }
    return resultString.substring(1);
  }
