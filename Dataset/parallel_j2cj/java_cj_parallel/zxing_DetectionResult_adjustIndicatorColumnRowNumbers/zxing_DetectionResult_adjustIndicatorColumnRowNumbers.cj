    func adjustIndicatorColumnRowNumbers(detectionResultColumn: ?DetectionResultColumn) {
        if (let Some(d) = detectionResultColumn) {
            (detectionResultColumn as DetectionResultRowIndicatorColumn).getOrThrow().
            adjustCompleteIndicatorColumnRowNumbers(barcodeMetadata)
        }
    }