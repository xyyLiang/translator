    func adjustRowNumbersFromRRI(): Int64 {
        if (let Some(d) = detectionResultColumns[barcodeColumnCount + 1]) {
            var unadjustedCount = 0
            let codewords = d.codewords
            for (codewordsRow in 0..codewords.size) {
                if (let Some(r) = codewords[codewordsRow]) {
                    let rowIndicatorRowNumber = r.rowNumber
                    var invalidRowCounts = 0
                    for (barcodeColumn in (barcodeColumnCount + 1)..0 : -1) {
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