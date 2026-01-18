    static func getRowIndicatorColumn(
        image: BitMatrix,
        boundingBox: BoundingBox,
        startPoint: ResultPoint,
        leftToRight: Bool,
        minCodewordWidth: Int64,
        maxCodewordWidth: Int64
    ): DetectionResultRowIndicatorColumn {
        let rowIndicatorColumn = DetectionResultRowIndicatorColumn(boundingBox, leftToRight)
        for (i in 0..2) {
            let increment = if (i == 0) {
                1
            } else {
                -1
            }
            var startColumn = Int64(startPoint.x)
            for (imageRow in Int64(startPoint.y)..=boundingBox.maxY : increment) {
                if (imageRow < boundingBox.minY) {
                    break
                }
                let codeword = detectCodeword(
                    image,
                    0,
                    image.width,
                    leftToRight,
                    startColumn,
                    imageRow,
                    minCodewordWidth,
                    maxCodewordWidth
                )
                if (let Some(c) = codeword) {
                    rowIndicatorColumn.setCodeword(imageRow, c)
                    if (leftToRight) {
                        startColumn = c.startX
                    } else {
                        startColumn = c.endX
                    }
                }
            }
        }
        rowIndicatorColumn
    }