    func adjustRowNumbers(): Int64 {
        let unadjustedCount = adjustRowNumbersByRow()
        if (unadjustedCount == 0) {
            return 0
        }
        for (barcodeColumn in 1..(barcodeColumnCount + 1)) {
            let codewords = detectionResultColumns[barcodeColumn].getOrThrow().codewords
            for (codewordsRow in 0..codewords.size) {
                if (let Some(c) = codewords[codewordsRow]) {
                    if (!c.hasValidRowNumber()) {
                        adjustRowNumbers(barcodeColumn, codewordsRow, codewords)
                    }
                }
            }
        }
        unadjustedCount
    }