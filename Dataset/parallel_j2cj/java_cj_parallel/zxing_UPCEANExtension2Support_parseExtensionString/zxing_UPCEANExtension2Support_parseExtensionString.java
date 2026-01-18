  private static Map<ResultMetadataType,Object> parseExtensionString(String raw) {
    if (raw.length() != 2) {
      return null;
    }
    Map<ResultMetadataType,Object> result = new EnumMap<>(ResultMetadataType.class);
    result.put(ResultMetadataType.ISSUE_NUMBER, Integer.valueOf(raw));
    return result;
  }