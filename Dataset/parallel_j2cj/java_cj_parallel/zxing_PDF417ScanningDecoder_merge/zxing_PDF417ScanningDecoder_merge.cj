
    static func merge(
        leftRowIndicatorColumn: ?DetectionResultRowIndicatorColumn,
        rightRowIndicatorColumn: ?DetectionResultRowIndicatorColumn
    ): ?DetectionResult {
        if (let (None, None) = (leftRowIndicatorColumn, rightRowIndicatorColumn)) {
            return None
        }
        let barcodeMetadata = getBarcodeMetadata(leftRowIndicatorColumn, rightRowIndicatorColumn)
        if (let Some(bm) = barcodeMetadata) {
            let boundingBox = BoundingBox.merge(
                adjustBoundingBox(leftRowIndicatorColumn),
                adjustBoundingBox(rightRowIndicatorColumn)
            )
            DetectionResult(bm, boundingBox)
        } else {
            None
        }
    }