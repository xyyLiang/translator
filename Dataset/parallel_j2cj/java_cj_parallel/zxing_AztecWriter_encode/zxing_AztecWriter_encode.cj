    public func encode(
        contents: String,
        format: BarcodeFormat,
        width: Int64,
        height: Int64,
        hints: ?HashMap<EncodeHintType, Any>
    ): BitMatrix {
        var eccPercent = Encoder.DEFAULT_EC_PERCENT
        var layers = Encoder.DEFAULT_AZTEC_LAYERS
        if (let Some(h) = hints) {
            if (h.contains(EncodeHintType.ERROR_CORRECTION)) {
                eccPercent = (h[EncodeHintType.ERROR_CORRECTION] as Int64).getOrThrow()
            }
            if (h.contains(EncodeHintType.AZTEC_LAYERS)) {
                layers = (h[EncodeHintType.AZTEC_LAYERS] as Int64).getOrThrow()
            }
        }
        encode0(contents, format, width, height, eccPercent, layers)
    }