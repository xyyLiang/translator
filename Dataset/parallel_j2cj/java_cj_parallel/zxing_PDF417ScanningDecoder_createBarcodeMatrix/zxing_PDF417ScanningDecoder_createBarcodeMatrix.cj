    static func createBarcodeMatrix(detectionResult: DetectionResult): Array<Array<BarcodeValue>> {
        let barcodeMatrix = Array<Array<BarcodeValue>>(
            detectionResult.getBarcodeRowCount(),
            {
                n => Array<BarcodeValue>(detectionResult.barcodeColumnCount + 2, {
                        m => BarcodeValue()
                    })
            }
        )
        var column = 0
        for (detectionResultColumn in detectionResult.getDetectionResultColumns()) {
            if (let Some(drc) = detectionResultColumn) {
                for (codeword in drc.codewords) {
                    if (let Some(c) = codeword) {
                        let rowNumber = c.rowNumber
                        if (rowNumber >= 0) {
                            if (rowNumber >= barcodeMatrix.size) {
                                continue
                            }
                            barcodeMatrix[rowNumber][column].setValue(c.value)
                        }
                    }
                }
            }
            column++
        }
        barcodeMatrix
    }
