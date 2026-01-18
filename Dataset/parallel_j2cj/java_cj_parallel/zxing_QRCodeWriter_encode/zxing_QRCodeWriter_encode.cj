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

        if (format != BarcodeFormat.QR_CODE) {
            throw IllegalArgumentException("Can only encode QR_CODE, but got ${format}")
        }

        if (width < 0 || height < 0) {
            throw IllegalArgumentException("Requested dimensions are too small: ${width}x${height}")
        }

        var errorCorrectionLevel = ErrorCorrectionLevel.L
        var quietZone = QUIET_ZONE_SIZE
        if (let Some(h) = hints) {
            if (let Some(err) = h.get(EncodeHintType.ERROR_CORRECTION)) {
                errorCorrectionLevel = ErrorCorrectionLevel.valueOf((err as String).getOrThrow())
            }
            if (let Some(m) = h.get(EncodeHintType.MARGIN)) {
                quietZone = (m as Int64).getOrThrow()
            }
        }

        let code = Encoder.encode(contents, errorCorrectionLevel, hints)
        renderResult(code, width, height, quietZone)
    }