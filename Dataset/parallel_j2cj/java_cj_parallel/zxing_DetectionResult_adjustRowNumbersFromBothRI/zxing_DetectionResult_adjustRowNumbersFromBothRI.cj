    func adjustRowNumbersFromBothRI() {
        if (let (Some(l), Some(r)) = (detectionResultColumns[0], detectionResultColumns[barcodeColumnCount + 1])) {
            let LRIcodewords = l.codewords
            let RRIcodewords = r.codewords
            for (codewordsRow in 0..LRIcodewords.size) {
                if (let (Some(lri), Some(rri)) = (LRIcodewords[codewordsRow], RRIcodewords[codewordsRow])) {
                    if (lri.rowNumber == rri.rowNumber) {
                        for (barcodeColumn in 1..=barcodeColumnCount) {
                            if (let Some(codeword) = detectionResultColumns[barcodeColumn].getOrThrow().codewords[codewordsRow]) {
                                codeword.rowNumber = LRIcodewords[codewordsRow].getOrThrow().rowNumber
                                if (!codeword.hasValidRowNumber()) {
                                    detectionResultColumns[barcodeColumn].getOrThrow().codewords[codewordsRow] = None
                                }
                            }
                        }
                    }
                }
            }
        }
    }