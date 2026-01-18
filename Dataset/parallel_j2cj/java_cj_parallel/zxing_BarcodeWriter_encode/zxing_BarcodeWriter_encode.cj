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

        if (width < 0 || height < 0) {
            throw IllegalArgumentException("Negative size is not allowed. Input: ${width}x${height}")
        }

        let supportedFormats = getSupportedWriteFormats()
        if (let Some(s) = supportedFormats) {
            if (!s.contains(format)) {
                throw IllegalArgumentException("Can only encode ${s}, but got ${format}")
            }
        }

        var sidesMargin = getDefaultMargin()
        if (let Some(h) = hints) {
            if (let Some(m) = h.get(EncodeHintType.MARGIN)) {
                sidesMargin = (m as Int64).getOrThrow()
            }
        }

        let code = encode(contents, hints)
        renderResult(code, width, height, sidesMargin)
    }
