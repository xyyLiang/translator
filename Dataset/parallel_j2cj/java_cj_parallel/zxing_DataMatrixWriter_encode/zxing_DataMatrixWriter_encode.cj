    public func encode(
        contents: String,
        format: BarcodeFormat,
        width: Int64,
        height: Int64,
        hints: ?HashMap<EncodeHintType, Any>
    ): BitMatrix {
        if (contents.isEmpty()) {
            throw IllegalArgumentException("Found empty contents")
        }

        if (format != BarcodeFormat.DATA_MATRIX) {
            throw IllegalArgumentException("Can only encode DATA_MATRIX, but got ${format}")
        }

        if (width < 0 || height < 0) {
            throw IllegalArgumentException("Requested dimensions can't be negative: ${width}x${height}")
        }

        var shape = SymbolShapeHint.FORCE_NONE
        var minSize: ?Dimension = None
        var maxSize: ?Dimension = None
        var hasCompactionHint = false
        if (let Some(h) = hints) {
            if (let Some(requestedShape) = (h[EncodeHintType.DATA_MATRIX_SHAPE] as SymbolShapeHint)) {
                shape = requestedShape
            }
            if (let Some(requestedMinSize) = (h[EncodeHintType.MIN_SIZE] as Dimension)) {
                minSize = requestedMinSize
            }
            if (let Some(requestedMaxSize) = (h[EncodeHintType.MAX_SIZE] as Dimension)) {
                maxSize = requestedMaxSize
            }
            if (let Some(has) = (h[EncodeHintType.DATA_MATRIX_COMPACT] as Bool)) {
                hasCompactionHint = has
            }
        }
        let encoded = if (hasCompactionHint) {
            let hasGS1FormatHint = (hints.getOrThrow()[EncodeHintType.GS1_FORMAT] as Bool) ?? false
            MinimalEncoder.encodeHighLevel(
                contents,
                if (hasGS1FormatHint) {
                    0x1D
                } else {
                    -1
                },
                shape
            )
        } else {
            let hasForceC40Hint = (hints.getOrThrow()[EncodeHintType.FORCE_C40] as Bool) ?? false
            HighLevelEncoder.encodeHighLevel(contents, shape, minSize, maxSize, hasForceC40Hint)
        }

        let symbolInfo = SymbolInfo.lookup(encoded.size, shape, minSize, maxSize, true)

        let codewords = ErrorCorrection.encodeECC200(encoded, symbolInfo.getOrThrow())

        let placement = DefaultPlacement(codewords, symbolInfo.getOrThrow().getSymbolDataWidth(), symbolInfo.getOrThrow().getSymbolDataHeight())
        placement.place()
        encodeLowLevel(placement, symbolInfo.getOrThrow(), width, height)
    }