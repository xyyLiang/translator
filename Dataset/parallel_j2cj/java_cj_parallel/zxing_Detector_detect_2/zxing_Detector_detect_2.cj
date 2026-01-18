    static func detect(multiple: Bool, bitMatrix: BitMatrix): ArrayList<Array<?ResultPoint>> {
        let barcodeCoordinates = ArrayList<Array<?ResultPoint>>()
        var row = 0
        var column = 0
        var foundBarcodeInRow = false
        while (row < bitMatrix.height) {
            let vertices = findVertices(bitMatrix, row, column)

            if (let (None, None) = (vertices[0], vertices[3])) {
                if (!foundBarcodeInRow) {
                    break
                }

                foundBarcodeInRow = false
                column = 0
                for (barcodeCoordinate in barcodeCoordinates) {
                    if (let Some(v) = barcodeCoordinate[1]) {
                        row = math.max(row, Int64(v.y))
                    }
                    if (let Some(v) = barcodeCoordinate[3]) {
                        row = math.max(row, Int64(v.y))
                    }
                }
                row += ROW_STEP
                continue
            }
            foundBarcodeInRow = true
            barcodeCoordinates.append(vertices)
            if (!multiple) {
                break
            }
            if (let Some(v) = vertices[2]) {
                column = Int64(v.x)
                row = Int64(v.y)
            } else if (let Some(v) = vertices[4]) {
                column = Int64(v.x)
                row = Int64(v.y)
            }
        }
        barcodeCoordinates
    }