    static func getBarcodeMetadata(
        leftRowIndicatorColumn: ?DetectionResultRowIndicatorColumn,
        rightRowIndicatorColumn: ?DetectionResultRowIndicatorColumn
    ): ?BarcodeMetadata {
        var leftBarcodeMetadata: ?BarcodeMetadata = None
        if (let Some(lr) = leftRowIndicatorColumn) {
            leftBarcodeMetadata = lr.getBarcodeMetadata()
        }
        if (let None = leftBarcodeMetadata) {
            return if (let Some(rr) = rightRowIndicatorColumn) {
                rr.getBarcodeMetadata()
            } else {
                None
            }
        }
        var rightBarcodeMetadata: ?BarcodeMetadata = None
        if (let Some(rr) = rightRowIndicatorColumn) {
            rightBarcodeMetadata = rr.getBarcodeMetadata()
        }
        if (let None = rightBarcodeMetadata) {
            return leftBarcodeMetadata
        }
        if (let (Some(l), Some(r)) = (leftBarcodeMetadata, rightBarcodeMetadata)) {
            if (l.columnCount != r.columnCount && l.errorCorrectionLevel != r.errorCorrectionLevel && l.rowCount != r.
            rowCount) {
                None
            } else {
                l
            }
        } else {
            None
        }
    }