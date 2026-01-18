    func adjustRowNumbers(barcodeColumn: Int64, codewordsRow: Int64, codewords: Array<?Codeword>) {
        let codeword = codewords[codewordsRow]
        let previousColumnCodewords = detectionResultColumns[barcodeColumn - 1].getOrThrow().codewords
        var nextColumnCodewords = previousColumnCodewords
        if (let Some(d) = detectionResultColumns[barcodeColumn + 1]) {
            nextColumnCodewords = d.codewords
        }

        let otherCodewords = Array<?Codeword>(14, {n => None})

        otherCodewords[2] = previousColumnCodewords[codewordsRow]
        otherCodewords[3] = nextColumnCodewords[codewordsRow]

        if (codewordsRow > 0) {
            otherCodewords[0] = codewords[codewordsRow - 1]
            otherCodewords[4] = previousColumnCodewords[codewordsRow - 1]
            otherCodewords[5] = nextColumnCodewords[codewordsRow - 1]
        }
        if (codewordsRow > 1) {
            otherCodewords[8] = codewords[codewordsRow - 2]
            otherCodewords[10] = previousColumnCodewords[codewordsRow - 2]
            otherCodewords[11] = nextColumnCodewords[codewordsRow - 2]
        }
        if (codewordsRow < codewords.size - 1) {
            otherCodewords[1] = codewords[codewordsRow + 1]
            otherCodewords[6] = previousColumnCodewords[codewordsRow + 1]
            otherCodewords[7] = nextColumnCodewords[codewordsRow + 1]
        }
        if (codewordsRow < codewords.size - 2) {
            otherCodewords[9] = codewords[codewordsRow + 2]
            otherCodewords[12] = previousColumnCodewords[codewordsRow + 2]
            otherCodewords[13] = nextColumnCodewords[codewordsRow + 2]
        }
        let c = codeword.getOrThrow()
        for (otherCodeword in otherCodewords) {
            if (adjustRowNumber(c, otherCodeword)) {
                return
            }
        }
    }