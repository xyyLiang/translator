    static func encode0(
        contents: String,
        format: BarcodeFormat,
        width: Int64,
        height: Int64,
        eccPercent: Int64,
        layers: Int64
    ): BitMatrix {
        if (format != BarcodeFormat.AZTEC) {
            throw IllegalArgumentException("Can only encode AZTEC, but got ${format}")
        }
        let aztec = Encoder.encode(contents, eccPercent, layers)
        renderResult(aztec, width, height)
    }