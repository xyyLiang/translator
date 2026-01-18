  private static int totalBitsInLayer(int layers, boolean compact) {
    return ((compact ? 88 : 112) + 16 * layers) * layers;
  }