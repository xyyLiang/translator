    func getDetectionResultColumns(): Array<?DetectionResultColumn> {
        adjustIndicatorColumnRowNumbers(detectionResultColumns[0])
        adjustIndicatorColumnRowNumbers(detectionResultColumns[barcodeColumnCount + 1])
        var unadjustedCodewordCount = PDF417Common.MAX_CODEWORDS_IN_BARCODE
        var previousUnadjustedCount = unadjustedCodewordCount
        do {
            previousUnadjustedCount = unadjustedCodewordCount
            unadjustedCodewordCount = adjustRowNumbers()
        } while (unadjustedCodewordCount > 0 && unadjustedCodewordCount < previousUnadjustedCount)
        detectionResultColumns
    }