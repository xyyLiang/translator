    func adjustRowNumbersFromLRI(): Int64 {
        if (let Some(d) = detectionResultColumns[0]) {
            var unadjustedCount = 0
            let codewords = d.codewords
            for (codewordsRow in 0..codewords.size) {
                if (let Some(r) = codewords[codewordsRow]) {
                    let rowIndicatorRowNumber = r.rowNumber
                    var invalidRowCounts = 0
                    for (barcodeColumn in 1..(barcodeColumnCount + 1)) {
                        if (invalidRowCounts >= ADJUST_ROW_NUMBER_SKIP) {
                            break
                        }
                        if (let Some(codeword) = detectionResultColumns[barcodeColumn].getOrThrow().codewords[codewordsRow]) {
                            invalidRowCounts = adjustRowNumberIfValid(rowIndicatorRowNumber, invalidRowCounts, codeword)
                            if (!codeword.hasValidRowNumber()) {
                                unadjustedCount++
                            }
                        }
                    }
                }
            }
            unadjustedCount
        } else {
            0
        }
    }