  private static String processVariableAI(int aiSize, int variableFieldSize, String rawInformation)
      throws NotFoundException {
    String ai = rawInformation.substring(0, aiSize);
    int maxSize = Math.min(rawInformation.length(), aiSize + variableFieldSize);
    String field = rawInformation.substring(aiSize, maxSize);
    String remaining = rawInformation.substring(maxSize);
    String result = '(' + ai + ')' + field;
    String parsedAI = parseFieldsInGeneralPurpose(remaining);
    return parsedAI == null ? result : result + parsedAI;
  }