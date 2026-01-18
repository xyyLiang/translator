  public static AztecCode encode(String data, int minECCPercent, int userSpecifiedLayers) {
    return encode(data.getBytes(StandardCharsets.ISO_8859_1), minECCPercent, userSpecifiedLayers, null);
  }