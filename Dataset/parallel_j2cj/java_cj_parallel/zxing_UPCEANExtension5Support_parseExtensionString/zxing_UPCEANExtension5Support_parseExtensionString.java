  private static Map<ResultMetadataType,Object> parseExtensionString(String raw) {
    if (raw.length() != 5) {
      return null;
    }
    Object value = parseExtension5String(raw);
    if (value == null) {
      return null;
    }
    Map<ResultMetadataType,Object> result = new EnumMap<>(ResultMetadataType.class);
    result.put(ResultMetadataType.SUGGESTED_PRICE, value);
    return result;
  }
