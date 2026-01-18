    func adjustCompleteIndicatorColumnRowNumbers(barcodeMetadata: BarcodeMetadata) {
        let codewords = this.codewords
        setRowNumbers()
        removeIncorrectCodewords(codewords, barcodeMetadata)
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
            if (let Some(codeword) = codewords[codewordsRow]) {
                let rowDifference = codeword.rowNumber - barcodeRow

                if (rowDifference == 0) {
                    currentRowHeight++
                } else if (rowDifference == 1) {
                    maxRowHeight = math.max(maxRowHeight, currentRowHeight)
                    currentRowHeight = 1
                    barcodeRow = codeword.rowNumber
                } else if (rowDifference < 0 || codeword.rowNumber >= barcodeMetadata.rowCount || rowDifference >
                    codewordsRow) {
                    codewords[codewordsRow] = None
                } else {
                    let checkedRows = if (maxRowHeight > 2) {
                        (maxRowHeight - 2) * rowDifference
                    } else {
                        rowDifference
                    }
                    var closePreviousCodewordFound = checkedRows >= codewordsRow
                    for (i in 1..=checkedRows) {
                        if (closePreviousCodewordFound) {
                            break
                        }
                        closePreviousCodewordFound = if (let None = codewords[codewordsRow - i]) {
                            false
                        } else {
                            true
                        }
                    }
                    if (closePreviousCodewordFound) {
                        codewords[codewordsRow] = None
                    } else {
                        barcodeRow = codeword.rowNumber
                        currentRowHeight = 1
                    }
                }
            }
        }
    }