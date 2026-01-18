    static func getStartColumn(
        detectionResult: DetectionResult,
        obarcodeColumn: Int64,
        imageRow: Int64,
        leftToRight: Bool
    ): Int64 {
        var barcodeColumn = obarcodeColumn
        let offset = if (leftToRight) {
            1
        } else {
            -1
        }
        var codeword: ?Codeword = None
        if (isValidBarcodeColumn(detectionResult, barcodeColumn - offset)) {
            codeword = detectionResult.getDetectionResultColumn(barcodeColumn - offset).getOrThrow().getCodeword(
                imageRow)
        }
        if (let Some(c) = codeword) {
            return if (leftToRight) {
                c.endX
            } else {
                c.startX
            }
        }
        codeword = detectionResult.getDetectionResultColumn(barcodeColumn).getOrThrow().getCodewordNearby(imageRow)
        if (let Some(c) = codeword) {
            return if (leftToRight) {
                c.startX
            } else {
                c.endX
            }
        }
        if (isValidBarcodeColumn(detectionResult, barcodeColumn - offset)) {
            codeword = detectionResult.getDetectionResultColumn(barcodeColumn - offset).getOrThrow().getCodewordNearby(
                imageRow)
        }
        if (let Some(c) = codeword) {
            return if (leftToRight) {
                c.endX
            } else {
                c.startX
            }
        }

        var skippedColumns = 0
        while (isValidBarcodeColumn(detectionResult, barcodeColumn - offset)) {
            barcodeColumn -= offset
            for (previousRowCodeword in detectionResult.getDetectionResultColumn(barcodeColumn).getOrThrow().codewords) {
                if (let Some(c) = previousRowCodeword) {
                    return (if (leftToRight) {
                        c.endX
                    } else {
                        c.startX
                    }) + offset * skippedColumns * (c.endX - c.startX)
                }
            }
            skippedColumns++
        }

        if (leftToRight) {
            detectionResult.boundingBox.getOrThrow().minX
        } else {
            detectionResult.boundingBox.getOrThrow().maxX
        }
    }