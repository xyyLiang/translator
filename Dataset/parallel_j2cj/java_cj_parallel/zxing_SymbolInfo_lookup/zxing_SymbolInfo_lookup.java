  public static SymbolInfo lookup(int dataCodewords,
                                  SymbolShapeHint shape,
                                  Dimension minSize,
                                  Dimension maxSize,
                                  boolean fail) {
    for (SymbolInfo symbol : symbols) {
      if (shape == SymbolShapeHint.FORCE_SQUARE && symbol.rectangular) {
        continue;
      }
      if (shape == SymbolShapeHint.FORCE_RECTANGLE && !symbol.rectangular) {
        continue;
      }
      if (minSize != null
          && (symbol.getSymbolWidth() < minSize.getWidth()
          || symbol.getSymbolHeight() < minSize.getHeight())) {
        continue;
      }
      if (maxSize != null
          && (symbol.getSymbolWidth() > maxSize.getWidth()
          || symbol.getSymbolHeight() > maxSize.getHeight())) {
        continue;
      }
      if (dataCodewords <= symbol.dataCapacity) {
        return symbol;
      }
    }
    if (fail) {
      throw new IllegalArgumentException(
          "Can't find a symbol arrangement that matches the message. Data codewords: "
              + dataCodewords);
    }
    return null;
  }
