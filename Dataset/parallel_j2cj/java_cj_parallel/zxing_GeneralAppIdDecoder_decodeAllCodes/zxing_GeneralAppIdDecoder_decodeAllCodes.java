  String decodeAllCodes(StringBuilder buff, int initialPosition) throws NotFoundException, FormatException {
    int currentPosition = initialPosition;
    String remaining = null;
    do {
      DecodedInformation info = this.decodeGeneralPurposeField(currentPosition, remaining);
      String parsedFields = FieldParser.parseFieldsInGeneralPurpose(info.getNewString());
      if (parsedFields != null) {
        buff.append(parsedFields);
      }
      if (info.isRemaining()) {
        remaining = String.valueOf(info.getRemainingValue());
      } else {
        remaining = null;
      }

      if (currentPosition == info.getNewPosition()) { // No step forward!
        break;
      }
      currentPosition = info.getNewPosition();
    } while (true);

    return buff.toString();
  }