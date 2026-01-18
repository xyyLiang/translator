    public func encode(
        contents: String,
        format: BarcodeFormat,
        width: Int64,
        height: Int64,
        hints: ?HashMap<EncodeHintType, Any>
    ): BitMatrix {
        if (format != BarcodeFormat.PDF_417) {
            throw IllegalArgumentException("Can only encode PDF_417, but got ${format}")
        }

        let encoder = PDF417()
        var margin = WHITE_SPACE
        var errorCorrectionLevel = DEFAULT_ERROR_CORRECTION_LEVEL
        var autoECI = false

        if (let Some(h) = hints) {
            if (h.contains(EncodeHintType.PDF417_COMPACT)) {
                let v = (h[EncodeHintType.PDF417_COMPACT] as String) ?? "false"
                encoder.compact = Bool.parse(v)
            }
            if (h.contains(EncodeHintType.PDF417_COMPACTION)) {
                let v = (h[EncodeHintType.PDF417_COMPACTION] as String) ?? ""
                encoder.compaction = Compaction.valueOf(v)
            }
            if (h.contains(EncodeHintType.PDF417_DIMENSIONS)) {
                let dimensions = (h[EncodeHintType.PDF417_DIMENSIONS] as Dimensions).getOrThrow()
                encoder.setDimensions(
                    dimensions.maxCols,
                    dimensions.minCols,
                    dimensions.maxRows,
                    dimensions.minRows
                )
            }
            if (h.contains(EncodeHintType.MARGIN)) {
                let v = (h[EncodeHintType.MARGIN] as String) ?? "0"
                margin = Int64.parse(v)
            }
            if (h.contains(EncodeHintType.ERROR_CORRECTION)) {
                let v = (h[EncodeHintType.ERROR_CORRECTION] as String) ?? "0"
                errorCorrectionLevel = Int64.parse(v)
            }
        }

        bitMatrixFromEncoder(encoder, contents, errorCorrectionLevel, width, height, margin, autoECI)
    }