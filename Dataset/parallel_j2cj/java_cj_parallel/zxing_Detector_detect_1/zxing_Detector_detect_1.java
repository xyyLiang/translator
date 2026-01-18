  public static PDF417DetectorResult detect(BinaryBitmap image, Map<DecodeHintType,?> hints, boolean multiple)
      throws NotFoundException {
    // TODO detection improvement, tryHarder could try several different luminance thresholds/blackpoints or even
    // different binarizers
    //boolean tryHarder = hints != null && hints.containsKey(DecodeHintType.TRY_HARDER);

    BitMatrix originalMatrix = image.getBlackMatrix();
    for (int rotation : ROTATIONS) {
      BitMatrix bitMatrix = applyRotation(originalMatrix, rotation);
      List<ResultPoint[]> barcodeCoordinates = detect(multiple, bitMatrix);
      if (!barcodeCoordinates.isEmpty()) {
        return new PDF417DetectorResult(bitMatrix, barcodeCoordinates, rotation);
      }
    }
    return new PDF417DetectorResult(originalMatrix, new ArrayList<>(), 0);
  }