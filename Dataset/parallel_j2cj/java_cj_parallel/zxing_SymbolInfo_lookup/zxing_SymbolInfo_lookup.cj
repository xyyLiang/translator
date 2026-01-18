    static func lookup(
        dataCodewords: Int64,
        shape: SymbolShapeHint,
        minSize: ?Dimension,
        maxSize: ?Dimension,
        fail: Bool
    ): ?SymbolInfo {
        for (symbol in symbols) {
            if (shape == SymbolShapeHint.FORCE_SQUARE && symbol.rectangular) {
                continue
            }
            if (shape == SymbolShapeHint.FORCE_RECTANGLE && !symbol.rectangular) {
                continue
            }
            if (let Some(min) = minSize) {
                if ((symbol.getSymbolWidth() < min.width || symbol.getSymbolHeight() < min.height)) {
                    continue
                }
            }
            if (let Some(max) = maxSize) {
                if ((symbol.getSymbolWidth() > max.width || symbol.getSymbolHeight() > max.height)) {
                    continue
                }
            }
            if (dataCodewords <= symbol.dataCapacity) {
                return symbol
            }
        }
        if (fail) {
            throw IllegalArgumentException(
                "Can't find a symbol arrangement that matches the message. Data codewords: ${dataCodewords}")
        }
        None
    }