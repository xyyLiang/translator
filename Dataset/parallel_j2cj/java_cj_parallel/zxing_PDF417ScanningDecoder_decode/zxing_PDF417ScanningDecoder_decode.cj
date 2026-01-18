    static func decode(
        image: BitMatrix,
        imageTopLeft: ?ResultPoint,
        imageBottomLeft: ?ResultPoint,
        imageTopRight: ?ResultPoint,
        imageBottomRight: ?ResultPoint,
        ominCodewordWidth: Int64,
        omaxCodewordWidth: Int64
    ): ?DecoderResult {
        var boundingBox = BoundingBox(image, imageTopLeft, imageBottomLeft, imageTopRight, imageBottomRight)
        var leftRowIndicatorColumn: ?DetectionResultRowIndicatorColumn = None
        var rightRowIndicatorColumn: ?DetectionResultRowIndicatorColumn = None
        var detectionResult: ?DetectionResult = None
        var firstPass = true
        var minCodewordWidth = ominCodewordWidth
        var maxCodewordWidth = omaxCodewordWidth
        while (true) {
            if (let Some(v) = imageTopLeft) {
                leftRowIndicatorColumn = getRowIndicatorColumn(
                    image,
                    boundingBox,
                    v,
                    true,
                    minCodewordWidth,
                    maxCodewordWidth
                )
            }
            if (let Some(v) = imageTopRight) {
                rightRowIndicatorColumn = getRowIndicatorColumn(
                    image,
                    boundingBox,
                    v,
                    false,
                    minCodewordWidth,
                    maxCodewordWidth
                )
            }
            detectionResult = merge(leftRowIndicatorColumn, rightRowIndicatorColumn)
            if (let Some(dr) = detectionResult) {
                let resultBox = dr.boundingBox
                if (firstPass && if (let None = resultBox) {
                    false
                } else {
                    true
                } && (resultBox.getOrThrow().minY < boundingBox.minY || resultBox.getOrThrow().maxY > boundingBox.maxY)) {
                    boundingBox = resultBox.getOrThrow()
                } else {
                    break
                }
                firstPass = false
            } else {
                throw NotFoundException()
            }
        }

        if (let Some(dr) = detectionResult) {
            dr.boundingBox = boundingBox
            let maxBarcodeColumn = dr.barcodeColumnCount + 1
            dr.setDetectionResultColumn(0, leftRowIndicatorColumn)
            dr.setDetectionResultColumn(maxBarcodeColumn, rightRowIndicatorColumn)
            var leftToRight = if (let None = leftRowIndicatorColumn) {
                false
            } else {
                true
            }
            for (barcodeColumnCount in 1..=maxBarcodeColumn) {
                let barcodeColumn = if (leftToRight) {
                    barcodeColumnCount
                } else {
                    maxBarcodeColumn - barcodeColumnCount
                }
                if (let Some(v) = dr.getDetectionResultColumn(barcodeColumn)) {
                    continue
                }
                let detectionResultColumn = if (barcodeColumn == 0 || barcodeColumn == maxBarcodeColumn) {
                    DetectionResultRowIndicatorColumn(boundingBox, barcodeColumn == 0)
                } else {
                    DetectionResultColumn(boundingBox)
                }
                dr.setDetectionResultColumn(barcodeColumn, detectionResultColumn)
                var startColumn = -1
                var previousStartColumn = startColumn
                for (imageRow in boundingBox.minY..=boundingBox.maxY) {
                    startColumn = getStartColumn(dr, barcodeColumn, imageRow, leftToRight)
                    if (startColumn < 0 || startColumn > boundingBox.maxX) {
                        if (previousStartColumn == -1) {
                            continue
                        }
                        startColumn = previousStartColumn
                    }
                    let codeword = detectCodeword(
                        image,
                        boundingBox.minX,
                        boundingBox.maxX,
                        leftToRight,
                        startColumn,
                        imageRow,
                        minCodewordWidth,
                        maxCodewordWidth
                    )
                    if (let Some(cw) = codeword) {
                        detectionResultColumn.setCodeword(imageRow, cw)
                        previousStartColumn = startColumn
                        minCodewordWidth = math.min(minCodewordWidth, cw.width)
                        maxCodewordWidth = math.max(maxCodewordWidth, cw.width)
                    }
                }
            }
        }
        createDecoderResult(detectionResult.getOrThrow())
    }