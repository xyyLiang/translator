    static func createDecoderResult(detectionResult: DetectionResult): ?DecoderResult {
        let barcodeMatrix = createBarcodeMatrix(detectionResult)
        adjustCodewordCount(detectionResult, barcodeMatrix)
        let erasures = ArrayList<Int64>()
        let codewords = Array<Int64>(detectionResult.getBarcodeRowCount() * detectionResult.barcodeColumnCount, item: 0)
        let ambiguousIndexValuesList = ArrayList<Array<Int64>>()
        let ambiguousIndexesList = ArrayList<Int64>()
        for (row in 0..detectionResult.getBarcodeRowCount()) {
            for (column in 0..detectionResult.barcodeColumnCount) {
                let values = barcodeMatrix[row][column + 1].getValue()
                let codewordIndex = row * detectionResult.barcodeColumnCount + column
                if (values.size == 0) {
                    erasures.append(codewordIndex)
                } else if (values.size == 1) {
                    codewords[codewordIndex] = values[0]
                } else {
                    ambiguousIndexesList.append(codewordIndex)
                    ambiguousIndexValuesList.append(values)
                }
            }
        }
        let ambiguousIndexValues = ambiguousIndexValuesList.toArray()
        createDecoderResultFromAmbiguousValues(
            detectionResult.getBarcodeECLevel(),
            codewords,
            PDF417Common.toIntArray(erasures),
            PDF417Common.toIntArray(ambiguousIndexesList),
            ambiguousIndexValues
        )
    }