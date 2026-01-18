  @Override
  public Result[] decodeMultiple(BinaryBitmap image, Map<DecodeHintType,?> hints) throws NotFoundException {
    try {
      return decode(image, hints, true);
    } catch (FormatException | ChecksumException ignored) {
      throw NotFoundException.getNotFoundInstance();
    }
  }