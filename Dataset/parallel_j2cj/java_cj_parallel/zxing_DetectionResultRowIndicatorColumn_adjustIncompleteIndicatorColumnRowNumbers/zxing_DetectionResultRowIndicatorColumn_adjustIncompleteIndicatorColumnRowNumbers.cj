    func adjustIncompleteIndicatorColumnRowNumbers(barcodeMetadata: BarcodeMetadata) {
        let boundingBox = this.boundingBox
        let top = if (isLeft) {
            boundingBox.topLeft
        } else {
            boundingBox.topRight
        }
        let bottom = if (isLeft) {
            boundingBox.bottomLeft
        } else {
            boundingBox.bottomRight
        }
        let firstRow = imageRowToCodewordIndex(Int64(top.y))
        let lastRow = imageRowToCodewordIndex(Int64(bottom.y))
        var barcodeRow = -1
        var maxRowHeight = 1
        var currentRowHeight = 0
        for (codewordsRow in firstRow..lastRow) {
            if (let Some(codeword) = this.codewords[codewordsRow]) {
                codeword.setRowNumberAsRowIndicatorColumn()
                let rowDifference = codeword.rowNumber - barcodeRow

                if (rowDifference == 0) {
                    currentRowHeight++
                } else if (rowDifference == 1) {
                    maxRowHeight = math.max(maxRowHeight, currentRowHeight)
                    currentRowHeight = 1
                    barcodeRow = codeword.rowNumber
                } else if (codeword.rowNumber >= barcodeMetadata.rowCount) {
                    codewords[codewordsRow] = None
                } else {
                    barcodeRow = codeword.rowNumber
                    currentRowHeight = 1
                }
            }
        }
    }