  @Override
  public Result decode(BinaryBitmap image, Map<DecodeHintType,?> hints) throws NotFoundException, FormatException,
      ChecksumException {
    Result[] result = decode(image, hints, false);
    if (result.length == 0 || result[0] == null) {
      throw NotFoundException.getNotFoundInstance();
    }
    return result[0];
  }