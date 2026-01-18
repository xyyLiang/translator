    public func setHints(hints: ?HashMap<DecodeHintType, Any>) {
        this.hints = hints
        let tryHarder = if (let Some(h) = hints) {
            h.contains(DecodeHintType.TRY_HARDER)
        } else {
            false
        }
        let readers = ArrayList<Reader>()
        if (let Some(formats) = if (let Some(h) = hints) {
            h[DecodeHintType.POSSIBLE_FORMATS] as Array<BarcodeFormat>
        } else {
            Option<Array<BarcodeFormat>>.None
        }) {
            let addOneDReader = 
                formats.contains(BarcodeFormat.UPC_A) || formats.contains(BarcodeFormat.UPC_E) || formats.contains(
                BarcodeFormat.EAN_13) || formats.contains(BarcodeFormat.EAN_8) || formats.contains(
                BarcodeFormat.CODABAR) || formats.contains(BarcodeFormat.CODE_39) || formats.contains(
                BarcodeFormat.CODE_93) || formats.contains(BarcodeFormat.CODE_128) || formats.contains(
                BarcodeFormat.ITF) || formats.contains(BarcodeFormat.RSS_14) || formats.contains(
                BarcodeFormat.RSS_EXPANDED)

            if (addOneDReader && !tryHarder) {
                readers.append(MultiFormatBarcodeReader(hints))
            }
            if (formats.contains(BarcodeFormat.QR_CODE)) {
                readers.append(QRCodeReader())
            }
            if (formats.contains(BarcodeFormat.DATA_MATRIX)) {
                readers.append(DataMatrixReader())
            }
            if (formats.contains(BarcodeFormat.AZTEC)) {
                readers.append(AztecReader())
            }
            if (formats.contains(BarcodeFormat.PDF_417)) {
                readers.append(PDF417Reader())
            }
            if (formats.contains(BarcodeFormat.MAXICODE)) {
                readers.append(MaxiCodeReader())
            }
            if (addOneDReader && tryHarder) {
                readers.append(MultiFormatBarcodeReader(hints))
            }
        }
        if (readers.isEmpty()) {
            if (!tryHarder) {
                readers.append(MultiFormatBarcodeReader(hints))
            }

            readers.append(QRCodeReader())

            // TODO readers.append(DataMatrixReader())
            readers.append(AztecReader())

            // TODO readers.append(PDF417Reader())
            readers.append(MaxiCodeReader())
            if (tryHarder) {
                readers.append(MultiFormatBarcodeReader(hints))
            }
        }
        this.readers = readers.toArray()
    }