    public override func encode(contents: String, format: BarcodeFormat, width: Int64, height: Int64, 
        hints: ?HashMap<EncodeHintType, Any>): BitMatrix {
        if (format != BarcodeFormat.UPC_A) {
            throw IllegalArgumentException("Can only encode UPC-A, but got ${format}")
        }
        subWriter.encode("0${contents}", BarcodeFormat.EAN_13, width, height, hints)
    }