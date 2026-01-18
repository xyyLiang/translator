  private static BitMatrix encode(String contents, BarcodeFormat format,
                                  int width, int height,
                                  Charset charset, int eccPercent, int layers) {
    if (format != BarcodeFormat.AZTEC) {
      throw new IllegalArgumentException("Can only encode AZTEC, but got " + format);
    }
    AztecCode aztec = Encoder.encode(contents, eccPercent, layers, charset);
    return renderResult(aztec, width, height);
  }