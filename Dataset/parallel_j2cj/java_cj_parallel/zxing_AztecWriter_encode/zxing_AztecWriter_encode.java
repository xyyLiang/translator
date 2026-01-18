  @Override
  public BitMatrix encode(String contents, BarcodeFormat format, int width, int height, Map<EncodeHintType,?> hints) {
    Charset charset = null; // Do not add any ECI code by default
    int eccPercent = Encoder.DEFAULT_EC_PERCENT;
    int layers = Encoder.DEFAULT_AZTEC_LAYERS;
    if (hints != null) {
      if (hints.containsKey(EncodeHintType.CHARACTER_SET)) {
        charset = Charset.forName(hints.get(EncodeHintType.CHARACTER_SET).toString());
      }
      if (hints.containsKey(EncodeHintType.ERROR_CORRECTION)) {
        eccPercent = Integer.parseInt(hints.get(EncodeHintType.ERROR_CORRECTION).toString());
      }
      if (hints.containsKey(EncodeHintType.AZTEC_LAYERS)) {
        layers = Integer.parseInt(hints.get(EncodeHintType.AZTEC_LAYERS).toString());
      }
    }
    return encode(contents, format, width, height, charset, eccPercent, layers);
  }