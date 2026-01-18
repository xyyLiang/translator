    func getRowHeights(): ?Array<Int64> {
        if (let Some(barcodeMetadata) = getBarcodeMetadata()) {
            adjustIncompleteIndicatorColumnRowNumbers(barcodeMetadata)
            let result = Array<Int64>(barcodeMetadata.rowCount, item: 0)
            for (codeword in this.codewords) {
                if (let Some(c) = codeword) {
                    let rowNumber = c.rowNumber
                    if (rowNumber >= result.size) {
                        continue
                    }
                    result[rowNumber] += 1
                }
            }
            result
        } else {
            None
        }
    }